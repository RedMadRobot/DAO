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
    
    let dao = RealmDAO(RLMMessageTranslator())
    
    
    func testPersistMessage() {
        let message = Message(entityId: "abc", text: "text")
        
        do {
            try dao.persist(message)
        } catch {
            XCTFail("Persist is failed")
        }
        
        XCTAssertEqual(message, dao.read(message.entityId))
    }
    
    
    func testReadMessage() {
        let message = Message(entityId: "def", text: "text 2")
        do {
            try dao.persist(message)
        } catch {
            XCTFail("Persist is failed")
        }
        
        XCTAssertEqual(message, dao.read("def"))
    }
    
    
    func testEraseMessage() {
        let message = Message(entityId: "ghi", text: "text 2")
        do {
            try dao.persist(message)
            try dao.erase("ghi")
        } catch {
            XCTFail("Persist or erase is failed")
        }
        
        XCTAssertNil(dao.read("ghi"))
    }
    
    func testPersistListOfMessages() {
        try! dao.erase()
        XCTAssertEqual(dao.read().count, 0)
        
        let m1 = Message(entityId: "1", text: "1")
        let m2 = Message(entityId: "2", text: "2")
        let m3 = Message(entityId: "3", text: "3")
        
        do{
            try dao.persist([m1, m2, m3])
        } catch {
            XCTFail("Persist is failed")
        }
        XCTAssertEqual(dao.read().count, 3)
        
        
        let m55 = Message(entityId: "55", text: "55")
        let m66 = Message(entityId: "66", text: "66")
        
        do{
            try dao.persist([m1, m2, m3, m55, m66])
        } catch {
            XCTFail("Persist is failed")
        }
        XCTAssertEqual(dao.read().count, 5)
    }
}
