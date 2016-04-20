//
//  CoreDataDAO.swift
//  CoreDAO
//
//  Created by Ivan Vavilov on 2/4/16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import CoreData


public enum CoreDataDAOError: ErrorType {
    case UpdateError
    case CreateError
    case PersistAllError
}


public class CoreDataDAO<CDModel: NSManagedObject, Model: Entity> : DAO<Model> {

    private var translator: CoreDataTranslator<CDModel, Model>
    private var coordinator: NSPersistentStoreCoordinator?
    
    private override init()
    {
        preconditionFailure()
    }
    
    //MARK: - Public
    
    public convenience init(translator: CoreDataTranslator<CDModel, Model>) {
        self.init(translator: translator, storeName: "Database.db")
    }
    
    public convenience init(translator: CoreDataTranslator<CDModel, Model>, storeName: String) {
        self.init()
        self.translator = translator
        self.coordinator = StoreCoordinator(storeName: storeName)
    }
    
    //MARK: - DAO
    
    override public func persist(entity: Model) throws
    {
        if entryExist(entity.entityId) {
            if !updateEntryTransaction(entity) {
                throw CoreDataDAOError.UpdateError
            }
        } else {
            if !createEntryTransaction(entity) {
                throw CoreDataDAOError.CreateError
            }
        }
    }
    
    override public func persistAll(enitites: [Model]) throws
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
                throw CoreDataDAOError.PersistAllError
            }
        }
        
        result = result && (try? transactionContext.save()) != nil
        
        if (!result) {
            throw CoreDataDAOError.PersistAllError
        }
    }
    
    override public func read(entityId: String) -> Model? {
        var entity: Model?
        if let entries = try? self.context().executeFetchRequest(request(entityId)) {
            if entries.count > 0 {
                entity = translator.entityClass.init()
                translator.fillEntity(entity, withEntry: entries.first as! CDModel)
            }
        }
        
        return entity
    }
    
    override public func readAll() -> [Model]
    {
        return readAll(predicate: nil)
    }
    
    override public func readAll(predicate predicate: NSPredicate?) -> [Model]
    {
        var entities = [Model]()
        if let allEntries = (try? self.context().executeFetchRequest(request(predicate))) as? [CDModel] {
            entities = allEntries.map { entry in
                let entity = translator.entityClass.init()
                translator.fillEntity(entity, withEntry: entry)
                return entity
            }
        }
        
        return entities
    }
    
    override public func readAll(orderBy field: String?, ascending: Bool) -> [Model]
    {
        return readAll(predicate: nil, orderBy: field, ascending: ascending)
    }
    
    override public func readAll(predicate predicate: NSPredicate?, orderBy field: String?, ascending: Bool) -> [Model]
    {
        var entities = [Model]()
        if let allEntries = (try? self.context().executeFetchRequest(request(predicate, sortDescriptors: [NSSortDescriptor(key: field, ascending: ascending)]))) as? [CDModel] {
            entities = allEntries.map { entry in
                let entity = translator.entityClass.init()
                translator.fillEntity(entity, withEntry: entry)
                return entity
            }
        }
        
        return entities
    }
    
    override public func erase() throws
    {
        deleteAllEntriesTransaction()
    }
    
    override public func erase(entityId: String) throws
    {
        deleteEntryTransaction(entityId)
    }
    
    //MARK: - Private
    
    private func fetchEntries(entryId: String, inContext context: NSManagedObjectContext) -> [CDModel]
    {
        if let entries = (try? context.executeFetchRequest(request(entryId))) as? [CDModel] {
            return entries
        } else {
            return [CDModel]()
        }
    }
    
    private func request(entryId: String) -> NSFetchRequest
    {
        return request(predicate(entryId))
    }
    
    private func request(predicate: NSPredicate?) -> NSFetchRequest
    {
        return NSFetchRequest.fetchRequest(entryClass: translator.entryClass, predicate: predicate)
    }
    
    private func request(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) -> NSFetchRequest
    {
        return NSFetchRequest.fetchRequest(entryClass: translator.entryClass, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    private func predicate(entityId: String) -> NSPredicate
    {
        return NSPredicate(format: "entryId == %@", argumentArray: [entityId])
    }
    
    //MARK: - Transactions
    
    private func entryExist(entryId: String) -> Bool
    {
        let existingEntries = fetchEntries(entryId, inContext: self.context())
        return existingEntries.count > 0
    }
    
    private func updateEntryTransaction(entity: Model) -> Bool
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

    private func createEntryTransaction(entity: Model) -> Bool
    {
        let transactionContext = self.context()
        
        let entry = ManagedObject.object(translator.entryClass, inContext: transactionContext) as! CDModel //todo: generics
        let success = translator.fillEntry(entry, withEntity: entity, inContext: transactionContext)
        
        return success && ((try? transactionContext.save()) != nil)
    }
    
    private func deleteAllEntriesTransaction()
    {
        let transactionContext = self.context()
        
        if let allEntries = try? transactionContext.executeFetchRequest(request(nil)) as! [CDModel] {
            for entry in allEntries {
                transactionContext.deleteObject(entry)
            }
            _ = try? transactionContext.save()
        }
    }
    
    private func deleteEntryTransaction(entityId: String)
    {
        let transactionContext = self.context()
        
        let entriesWithId = fetchEntries(entityId, inContext: transactionContext)
        for entry in entriesWithId {
            transactionContext.deleteObject(entry)
        }
        _ = try? transactionContext.save()
    }
    
    private func context() -> NSManagedObjectContext
    {
        let context = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        context.persistentStoreCoordinator = self.coordinator
        return context
    }
}
