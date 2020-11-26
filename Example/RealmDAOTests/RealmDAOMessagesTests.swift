//
//  RealmDAOMessagesTests.swift
//  DAO
//
//  Created by Ivan Vavilov on 4/28/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import XCTest
import DAO
@testable import DAO_Example


final class RealmDAOMessagesTests: XCTestCase {
    
    private var dao: RealmDAO<Message, DBMessage>!
    
    override func setUp() {
        super.setUp()
        
        dao = RealmDAO(RLMMessageTranslator())
    }
    
    override func tearDown() {
        super.tearDown()
        
        try! dao.erase()
        dao = nil
    }
    
    func testPersistMessage() {
        let message = Message(entityId: "abc", text: "text")
        
        XCTAssertNoThrow(try dao.persist(message), "Persist is failed")
        XCTAssertEqual(message, dao.read(message.entityId))
    }
    
    func testReadMessage() {
        let message = Message(entityId: "def", text: "text 2")
        
        XCTAssertNoThrow(try dao.persist(message), "Persist is failed")
        XCTAssertEqual(message, dao.read("def"))
    }
    
    func testEraseMessage() {
        let message = Message(entityId: "ghi", text: "text 2")
        
        XCTAssertNoThrow(try dao.persist(message), "Persist or erase is failed")
        XCTAssertNoThrow(try dao.erase("ghi"), "Persist or erase is failed")
        XCTAssertNil(dao.read("ghi"))
    }
    
    func testPersistListOfMessages() {
        XCTAssertEqual(dao.read().count, 0)
        
        let message1 = Message(entityId: "1", text: "1")
        let message2 = Message(entityId: "2", text: "2")
        let message3 = Message(entityId: "3", text: "3")
        
        XCTAssertNoThrow(try dao.persist([message1, message2, message3]), "Persist is failed")
        let threeMessages = dao.read(orderedBy: "entryId", ascending: true)
        
        XCTAssertEqual(threeMessages.count, 3)
        XCTAssertEqual(threeMessages[0].entityId, "1")
        XCTAssertEqual(threeMessages[1].entityId, "2")
        XCTAssertEqual(threeMessages[2].entityId, "3")
        
        let message55 = Message(entityId: "55", text: "55")
        let message66 = Message(entityId: "66", text: "66")
        
        XCTAssertNoThrow(try dao.persist([message1, message2, message3, message55, message66]), "Persist is failed")
        
        let fiveMessages = dao.read(orderedBy: "entryId", ascending: true)
        
        XCTAssertEqual(fiveMessages.count, 5)
        XCTAssertEqual(fiveMessages[0].entityId, "1")
        XCTAssertEqual(fiveMessages[1].entityId, "2")
        XCTAssertEqual(fiveMessages[2].entityId, "3")
        XCTAssertEqual(fiveMessages[3].entityId, "55")
        XCTAssertEqual(fiveMessages[4].entityId, "66")
    }
    
}
