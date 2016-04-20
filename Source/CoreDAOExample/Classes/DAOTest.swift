//
//  DAOTest.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 05.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import UIKit
import CoreDAO



@UIApplicationMain
class DAOTest: UIResponder, UIApplicationDelegate {
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        print("\(NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first)")
        self.setupRealmdataBase()

        self.testRealmEntitiesDAO()
        self.testRealmMessageDAO()
        self.testRealmFoldersDAO()
        
        testCoreDataEntitiesDAO()
        
        return true
    }
    
    func setupRealmdataBase() {
        RealmDAO.assignDatabaseVersion(1)
        RealmDAO.assignDatabaseFilename("DAOTest.realm")
    }
    
    func testRealmEntitiesDAO() {
        self.testRealmPersist_EntityWithId_returnYES()
        self.testRealmReadById_entityExist_returnExactlyEntity()
        self.testRealmEraseById_entityExists_entityErased()
    }
    
    func testRealmMessageDAO() {
        self.testRealmPersist_messageWithAllFields_returnsYES()
        self.testRealmReadById_messageExists_returnsExactMessage()
        self.testRealmEraseById_messageExists_messageErased()
    }
    
    func testRealmFoldersDAO() {
        self.testRealmPersist_folderWithAllFields_returnsYES()
        self.testRealmReadById_folderExists_returnsExactFolder()
        self.testRealmReadById_folderWithMessages_returnsExactFolder()
        self.testRealmEraseById_folderExists_folderErased()
        self.testRealmEraseByIdCascade_folderExists_folderErasedWithMessages()
    }
    
    func testCoreDataEntitiesDAO() {
        testCoreDataPersist_entityWithId_returnsYES()
        testCoreDataPersistAll_entityWithId_returnsYES()
        testCoreDataPersistInBackground_entityWithId_returnsYES()
        testCoreDataReadById_entityExists_returnsExactEntity()
        testCoreDataReadById_entitySavedInBackground_returnsExactEntity()
        testCoreDataEraseById_entityExists_entityErased()
    }
    
    func testRealmPersist_EntityWithId_returnYES() {
        let dao = self.entityRealmDAO()
        let entity: Entity = Entity(entityId: "1")
        print("\(__FUNCTION__) result:\(dao.persist(entity))")
    }
    
    func testRealmReadById_entityExist_returnExactlyEntity() {
        let dao = self.entityRealmDAO()
        let entity = Entity(entityId: "2")
        dao.persist(entity)
        let savedEntity: Entity? = dao.read("2") 
        print("\(__FUNCTION__) result:\(entity == savedEntity)")
    }
    
    func testRealmEraseById_entityExists_entityErased() {
        let dao = self.entityRealmDAO()
        let entity = Entity(entityId: "3")
        dao.persist(entity)
        dao.erase("3")
        let erasedEntity: Entity? = dao.read("3") 
        print("\(__FUNCTION__) result:\(erasedEntity == nil)")
    }
    
    func testRealmPersist_messageWithAllFields_returnsYES() {
        let dao = self.messageDAO()
        let message = Message(entityId: "abc", text: "text")
        print("\(__FUNCTION__) result:\(dao.persist(message))")
    }
    
    func testRealmReadById_messageExists_returnsExactMessage() {
        let dao = self.messageDAO()
        let message = Message(entityId: "def", text: "text 2")
        dao.persist(message)
        let savedMessage =  dao.read("def") as! Message?
        
        print("\(__FUNCTION__) result:\(message == savedMessage)")
    }

    func testRealmEraseById_messageExists_messageErased() {
        let dao = self.entityRealmDAO()
        let message = Entity(entityId: "ghi")
        dao.persist(message)
        dao.erase("ghi")
        let erasedMessage = dao.read("ghi") as! Message?
        print("\(__FUNCTION__) result:\(erasedMessage == nil)")
    }
    
    private func testRealmPersist_folderWithAllFields_returnsYES() {
        let dao = self.folderDAO()
        let folder = Folder.folderWithId("I", name: "INBOX", messages: [])
        print("\(__FUNCTION__) result:\(dao.persist(folder))")
    }
    
    private func testRealmReadById_folderExists_returnsExactFolder() {
        let dao = self.folderDAO()
        let folderID = "II"
        let folder = Folder.folderWithId(folderID, name: "OUTBOX", messages: [])
        dao.persist(folder)
        let savedFolder = dao.read(folderID) as! Folder?
        
        print("\(__FUNCTION__) result:\(folder == savedFolder)")
    }
    
    private func testRealmReadById_folderWithMessages_returnsExactFolder() {
        let dao = self.folderDAO()
        let folderID = "IV"
        let message1 = Message(entityId: "IV.1", text: "text IV.1")
        let message2 = Message(entityId: "IV.2", text: "text IV.2")
        
        let folder = Folder.folderWithId(folderID, name: "SPAM", messages: [message1, message2])
        dao.persist(folder)
        let savedFolder = dao.read(folderID) as! Folder?
        
        print("\(__FUNCTION__) result:\(folder == savedFolder)")
    }
    
    private func testRealmEraseById_folderExists_folderErased() {
        let dao = self.folderDAO()
        let folderID = "III"
        
        let folder = Folder.folderWithId(folderID, name: "SENT", messages: [])
        dao.persist(folder)
        dao.erase(folderID)
        
        print("\(__FUNCTION__) result:\(dao.read(folderID) == nil)")
    }
    
    private func testRealmEraseByIdCascade_folderExists_folderErasedWithMessages() {
        let dao = self.folderDAO()
        
        let messageID = "V.message"
        let  message = Message.init(entityId: messageID, text: "V.message.text")
        
        let folderID = "V"
        let folder = Folder.folderWithId(folderID, name: "Delete", messages: [message])
        dao.persist(folder)
        
        let  messageDAO = self.messageDAO()
        let savedMessage = messageDAO.read(messageID)
        if (savedMessage == nil) { fatalError() }
        
        dao.erase(folderID)
        
        print("\(__FUNCTION__) result:\(messageDAO.read(messageID) == nil)")

    }
    
    // MARK: CoreData
    
    func testCoreDataPersist_entityWithId_returnsYES() {
        let dao = entityCoreDataDAO()
        let entity = Entity(entityId: "1")
        print("\(__FUNCTION__): \(dao.persist(entity))")
    }
    
    func testCoreDataPersistAll_entityWithId_returnsYES() {
        let dao = entityCoreDataDAO()
        let firstEntity = Entity(entityId: "1")
        let secondEntity = Entity(entityId: "2")
        print("\(__FUNCTION__): \(dao.persistAll([firstEntity, secondEntity]))")
    }
    
    func testCoreDataPersistInBackground_entityWithId_returnsYES() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            let dao = self.entityCoreDataDAO()
            let entity = Entity(entityId: "1_back")
            print("\(__FUNCTION__): \(dao.persist(entity))")
        }
    }
    
    func testCoreDataReadById_entityExists_returnsExactEntity() {
        let dao = entityCoreDataDAO()
        let entityId = "2"
        let entity = Entity(entityId: entityId)
        
        var result = false
        if dao.persist(entity) {
            if let savedEntity = dao.read(entityId) {
                result = savedEntity.entityId == entity.entityId
            }
        }
        
        print("\(__FUNCTION__): \(result)")
    }
    
    func testCoreDataReadById_entitySavedInBackground_returnsExactEntity() {
        let dao = entityCoreDataDAO()
        let entityId = "2_back"
        let entity = Entity(entityId: entityId)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            dao.persist(entity)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                var result = false
                if let savedEntity = dao.read(entityId) {
                    result = savedEntity.entityId == entity.entityId
                }
                print("\(__FUNCTION__): \(result)")
            })
        }
    }
    
    func testCoreDataEraseById_entityExists_entityErased() {
        let dao = entityCoreDataDAO()
        let entityId = "3"
        let entity = Entity(entityId: entityId)
        
        dao.persist(entity)
        dao.erase(entityId)
        
        print("\(__FUNCTION__): \(dao.read(entityId) == nil)")
    }
    
    // MARK: Инициализация DAO объектов
    
    private func entityRealmDAO() -> RealmDAO<Entity, DBEntity> {
        return RealmDAO(translator: RLMEntityTranslator.translator())
    }
    
    private func messageDAO() -> RealmDAO<Message, DBMessage> {
        let a = RealmDAO(translator: RLMMessageTranslator.translator())
        return a
    }
    
    private func folderDAO() -> RealmDAO<Folder, DBFolder> {
        return RealmDAO(translator: RLMFolderTranslator.translator())
    }
    
    private func entityCoreDataDAO() -> CoreDataDAO<CDEntity, Entity> {
        return CoreDataDAO(translator: CDEntityTranslator.translator())
    }
}