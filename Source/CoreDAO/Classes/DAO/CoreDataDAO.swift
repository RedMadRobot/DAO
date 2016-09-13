//
//  CoreDataDAO.swift
//  CoreDAO
//
//  Created by Ivan Vavilov on 2/4/16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import CoreData


public enum CoreDataDAOError: Error {
    case updateError
    case createError
    case persistAllError
}


open class CoreDataDAO<CDModel: NSManagedObject, Model: Entity> : DAO<Model> {

    fileprivate var translator: CoreDataTranslator<CDModel, Model>
    fileprivate var coordinator: NSPersistentStoreCoordinator?
    
    
    //MARK: - Public
    
    public convenience init(translator: CoreDataTranslator<CDModel, Model>) {
        self.init(translator: translator, storeName: "Database.db")
    }
    
    public init(translator: CoreDataTranslator<CDModel, Model>, storeName: String) {
        self.translator = translator
        self.coordinator = StoreCoordinator(storeName: storeName)
    }
    
    //MARK: - DAO
    
    override open func persist(_ entity: Model) throws
    {
        if entryExist(entity.entityId) {
            if !updateEntryTransaction(entity) {
                throw CoreDataDAOError.updateError
            }
        } else {
            if !createEntryTransaction(entity) {
                throw CoreDataDAOError.createError
            }
        }
    }
    
    override open func persistAll(_ enitites: [Model]) throws
    {
        let transactionContext = self.context()
        var result = true
        
        for entity in enitites {
            var success: Bool
            
            if entryExist(entity.entityId) {
                success = false
                let existingEntries = fetchEntries(entity.entityId, inContext: transactionContext)
                if (existingEntries.count > 0) {
                    success = true
                    for entry in existingEntries {
                        success = success && translator.fillEntry(entry, withEntity: entity, inContext: transactionContext)
                    }
                }
                
                result = success && result
            } else {
                let entry = ManagedObject.object(translator.entryClass, inContext: transactionContext) as! CDModel

                success = translator.fillEntry(entry, withEntity: entity, inContext: transactionContext)
                result = success && result
            }
            
            if (!result) {
                throw CoreDataDAOError.persistAllError

            }
        }
        
        result = result && (try? transactionContext.save()) != nil
        
        if (!result) {
            throw CoreDataDAOError.persistAllError
        }

    }
    
    override open func read(_ entityId: String) -> Model? {
        var entity: Model?
        if let entries = try? self.context().fetch(request(entityId)) {
            if entries.count > 0 {
                entity = translator.entityClass.init()
                translator.fillEntity(entity, withEntry: entries.first as! CDModel)
            }
        }
        
        return entity
    }
    
    override open func readAll() -> [Model]
    {
        return readAll(predicate: nil)
    }
    
    override open func readAll(predicate: NSPredicate?) -> [Model]
    {
        var entities = [Model]()
        if let allEntries = (try? self.context().fetch(request(predicate))) as? [CDModel] {
            entities = allEntries.map { entry in
                let entity = translator.entityClass.init()
                translator.fillEntity(entity, withEntry: entry)
                return entity
            }
        }
        
        return entities
    }
    
    override open func readAll(orderBy field: String?, ascending: Bool) -> [Model]
    {
        return readAll(predicate: nil, orderBy: field, ascending: ascending)
    }
    
    override open func readAll(predicate: NSPredicate?, orderBy field: String?, ascending: Bool) -> [Model]
    {
        var entities = [Model]()
        if let allEntries = (try? self.context().fetch(request(predicate, sortDescriptors: [NSSortDescriptor(key: field, ascending: ascending)]))) as? [CDModel] {
            entities = allEntries.map { entry in
                let entity = translator.entityClass.init()
                translator.fillEntity(entity, withEntry: entry)
                return entity
            }
        }
        
        return entities
    }
    
    override open func erase() throws
    {
        deleteAllEntriesTransaction()
    }
    
    override open func erase(_ entityId: String) throws
    {
        deleteEntryTransaction(entityId)
    }
    
    //MARK: - Private
    
    fileprivate func fetchEntries(_ entryId: String, inContext context: NSManagedObjectContext) -> [CDModel]
    {
        if let entries = (try? context.fetch(request(entryId))) as? [CDModel] {
            return entries
        } else {
            return [CDModel]()
        }
    }
    
    fileprivate func request(_ entryId: String) -> NSFetchRequest<AnyObject>
    {
        return request(predicate(entryId))
    }
    
    fileprivate func request(_ predicate: NSPredicate?) -> NSFetchRequest<AnyObject>
    {
        return NSFetchRequest.fetchRequest(entryClass: translator.entryClass, predicate: predicate)
    }
    
    fileprivate func request(_ predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) -> NSFetchRequest<AnyObject>
    {
        return NSFetchRequest.fetchRequest(entryClass: translator.entryClass, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    fileprivate func predicate(_ entityId: String) -> NSPredicate
    {
        return NSPredicate(format: "entryId == %@", argumentArray: [entityId])
    }
    
    //MARK: - Transactions
    
    fileprivate func entryExist(_ entryId: String) -> Bool
    {
        let existingEntries = fetchEntries(entryId, inContext: self.context())
        return existingEntries.count > 0
    }
    
    fileprivate func updateEntryTransaction(_ entity: Model) -> Bool
    {
        let transactionContext = self.context()
        var success = false
        
        let existingEntries = self.fetchEntries(entity.entityId, inContext: transactionContext)
        
        if (existingEntries.count > 0) {
            success = true
            for entry in existingEntries {
                success = success && translator.fillEntry(entry, withEntity: entity, inContext: transactionContext)
            }
            success = success && ((try? transactionContext.save()) != nil)
        }
        
        return success
    }

    fileprivate func createEntryTransaction(_ entity: Model) -> Bool
    {
        let transactionContext = self.context()
        
        let entry = ManagedObject.object(translator.entryClass, inContext: transactionContext) as! CDModel //todo: generics
        let success = translator.fillEntry(entry, withEntity: entity, inContext: transactionContext)
        
        return success && ((try? transactionContext.save()) != nil)
    }
    
    fileprivate func deleteAllEntriesTransaction()
    {
        let transactionContext = self.context()
        
        if let allEntries = try? transactionContext.fetch(request(nil)) as! [CDModel] {
            for entry in allEntries {
                transactionContext.delete(entry)
            }
            _ = try? transactionContext.save()
        }
    }
    
    fileprivate func deleteEntryTransaction(_ entityId: String)
    {
        let transactionContext = self.context()
        
        let entriesWithId = fetchEntries(entityId, inContext: transactionContext)
        for entry in entriesWithId {
            transactionContext.delete(entry)
        }
        _ = try? transactionContext.save()
    }
    
    fileprivate func context() -> NSManagedObjectContext
    {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = self.coordinator
        return context
    }
}
