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
    
    let messageDAO = RealmDAO(RLMMessageTranslator())
    
    let folderDAO = RealmDAO(RLMFolderTranslator())
    
    
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
