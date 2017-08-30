//
//  RealmDAOFolderTests.swift
//  DAO
//
//  Created by Ivan Vavilov on 4/28/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import XCTest
import DAO
@testable import DAO_Example


final class RealmDAOFolderTests: XCTestCase {
    
    let messageDAO = RealmDAO(RLMMessageTranslator(), configuration: RealmConfiguration(databaseVersion: 2))
    let folderDAO = RealmDAO(RLMFolderTranslator(), configuration: RealmConfiguration(databaseVersion: 2))
    let userDAO = RealmDAO(RLMUserTranslator(), configuration: RealmConfiguration(databaseVersion: 2))
    
    override func setUp() {
        try? messageDAO.erase()
        try? folderDAO.erase()
        try? userDAO.erase()
    }
    
    func testUserRelationship() {
        let user = User(entityId: "U1", name: "Vova")
        let folder = Folder(entityId: "F1", name: "Created", creator: user, messages: [])
        
        do {
            try folderDAO.persist(folder)
        } catch {
            XCTFail("Persist folder is failed")
        }
        
        let savedFolder = folderDAO.read("F1")
        
        XCTAssertNotNil(savedFolder?.creator)
    }
    
    func testUpdateUserInRelationship() {
        let user = User(entityId: "U1", name: "Vova")
        let folder = Folder(entityId: "F1", name: "Created", creator: user, messages: [])
        
        do {
            try folderDAO.persist(folder)
        } catch {
            XCTFail("Persist folder is failed")
        }
        
        let savedFolder = folderDAO.read("F1")!
        savedFolder.creator = nil
        
        do {
            try folderDAO.persist(savedFolder)
        } catch {
            XCTFail("Persist folder is failed")
        }
        
        if let savedFolder = folderDAO.read("F1") {
            XCTAssertNil(savedFolder.creator)
        } else {
            XCTFail("Persist folder is failed")
        }
        
        let user2 = User(entityId: "U2", name: "Vova")
        
        savedFolder.creator = user2
        
        do {
            try folderDAO.persist(savedFolder)
        } catch {
            XCTFail("Persist folder is failed")
        }
        
        if let savedFolder = folderDAO.read("F1") {
            XCTAssertEqual(savedFolder.creator?.entityId, "U2")
        } else {
            XCTFail("Persist folder is failed")
        }
        
        do {
            try userDAO.erase()
        } catch {
            XCTFail("Erase user is failed")
        }
        
        savedFolder.creator = user
        
        do {
            try folderDAO.persist(savedFolder)
        } catch {
            XCTFail("Persist folder is failed")
        }
        
        if let savedFolder = folderDAO.read("F1") {
            XCTAssertEqual(savedFolder.creator?.entityId, "U1")
        } else {
            XCTFail("Persist folder is failed")
        }
        
    }
    
    func testCascadeErase() {
        let message = Message(entityId: "V.message", text: "V.message.text")
        let folder = Folder(entityId: "V", name: "Delete", messages: [message])
        
        do {
            try folderDAO.persist(folder)
        } catch {
            XCTFail("Persist folder is failed")
        }
        
        let savedMessage = messageDAO.read("V.message")
        
        XCTAssertNotNil(savedMessage)
        
        do {
            try folderDAO.erase("V")
        } catch {
            XCTFail("Erase folder is failed")
        }
        
        XCTAssertNil(messageDAO.read("V.message"))
    }

    
}
