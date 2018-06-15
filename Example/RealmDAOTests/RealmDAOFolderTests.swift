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
    
    private var messageDAO: RealmDAO<Message, DBMessage>!
    private var folderDAO: RealmDAO<Folder, DBFolder>!
    
    override func setUp() {
        super.setUp()
        
        messageDAO = RealmDAO(RLMMessageTranslator())
        folderDAO = RealmDAO(RLMFolderTranslator())
    }
    
    override func tearDown() {
        super.tearDown()
        
        try! messageDAO.erase()
        try! folderDAO.erase()
        
        messageDAO = nil
        folderDAO = nil
    }
    
    func testCascadeErase() {
        let message = Message(entityId: "V.message", text: "V.message.text")
        let folder = Folder(entityId: "V", name: "Delete", messages: [message])
        
        XCTAssertNoThrow(try folderDAO.persist(folder), "Persist folder is failed")
        XCTAssertNotNil(messageDAO.read("V.message"))
        XCTAssertNoThrow(try folderDAO.erase("V"), "Erase folder is failed")
        XCTAssertNil(messageDAO.read("V.message"))
    }
    
}
