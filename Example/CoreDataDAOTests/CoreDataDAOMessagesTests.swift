//
//  CoreDataDAOMessagesTests.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/2/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import XCTest
import DAO
import CoreData
@testable import DAO_Example


final class CoreDataDAOMessagesTests: XCTestCase {
    
    let dao = try! CoreDataDAO(
        CDMessageTranslator(),
        configuration: CoreDataConfiguration(
            containerName: "Model",
            storeType: NSInMemoryStoreType))
    
    
    func testPersistMessage() {
        let message = Message(entityId: "abc", text: "text")
        
        do {
            try dao.persist(message)
        } catch _ {
            XCTFail("Persist message is failed")
        }
        
        XCTAssertEqual(message, dao.read(message.entityId))
    }
    
    
    func testReadMessage() {
        let message = Message(entityId: "def", text: "text 2")
        
        do {
            try dao.persist(message)
        } catch _ {
            XCTFail("Read message is failed")
        }
        
        XCTAssertEqual(message, dao.read("def"))
    }
    
    
    func testEraseMessage() {
        let message = Message(entityId: "ghi", text: "text 2")
        
        do {
            try dao.persist(message)
            try dao.erase("ghi")
        } catch _ {
            XCTFail("Erase message is failed")
        }
        
        XCTAssertNil(dao.read("ghi"))
    }

    
    
}
