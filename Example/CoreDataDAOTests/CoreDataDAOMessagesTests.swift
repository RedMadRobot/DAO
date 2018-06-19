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
    
    private var dao: CoreDataDAO<CDMessage, Message>!
    
    override func setUp() {
        super.setUp()
        
        let translator = CDMessageTranslator()
        let configuration = CoreDataConfiguration(
            containerName: "Model",
            storeType: NSInMemoryStoreType
        )
        
        dao = try! CoreDataDAO(
            translator,
            configuration: configuration
        )
    }
    
    override func tearDown() {
        super.tearDown()
        
        try! dao.erase()
        dao = nil
    }
    
    func testPersistMessage() {
        let message = Message(entityId: "abc", text: "text")
        
        XCTAssertNoThrow(try dao.persist(message), "Persist message is failed")
        XCTAssertEqual(message, dao.read(message.entityId))
    }
    
    func testReadMessage() {
        let message = Message(entityId: "def", text: "text 2")
        
        XCTAssertNoThrow(try dao.persist(message), "Read message is failed")
        XCTAssertEqual(message, dao.read("def"))
    }
    
    func testEraseMessage() {
        let message = Message(entityId: "ghi", text: "text 2")
        
        XCTAssertNoThrow(try dao.persist(message), "Erase message is failed")
        XCTAssertNoThrow(try dao.erase("ghi"), "Erase message is failed")
        XCTAssertNil(dao.read("ghi"))
    }
    
}
