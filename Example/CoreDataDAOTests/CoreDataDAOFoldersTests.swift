//
//  CoreDataDAOFoldersTests.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/23/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import XCTest
import DAO
import CoreData
@testable import DAO_Example


final class CoreDataDAOFoldersTests: XCTestCase {
    
    let dao = try! CoreDataDAO(
        CDFolderTranslator(),
        configuration: CoreDataConfiguration(
            containerName: "Model",
            storeType: NSInMemoryStoreType))
    
    
    func testPersistMessages() {
        let message1 = Message(entityId: "abc", text: "text1")
        let message2 = Message(entityId: "bcc", text: "text2")
        
        let folder = Folder(entityId: "fld", name: "Home", messages: [message1, message2])
        
        do {
            try dao.persist(folder)
        } catch _ {
            XCTFail("Persist folder is failed")
        }
        
        if let savedFolder = dao.read(folder.entityId) {
            XCTAssertEqual(folder.messages.count, savedFolder.messages.count)
        } else {
            XCTFail("Persist folder is failed")
        }
    }
    
}
