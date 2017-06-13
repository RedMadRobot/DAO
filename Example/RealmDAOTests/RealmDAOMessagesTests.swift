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
    
}
