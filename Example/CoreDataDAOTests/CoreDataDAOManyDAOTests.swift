//
//  CoreDataDAOManyDAOTests.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/22/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import XCTest
import DAO
import CoreData
@testable import DAO_Example


final class CoreDataDAOManyDAOTests: XCTestCase {
    
    let messagesDAO = try! CoreDataDAO(
        CDMessageTranslator(),
        configuration: CoreDataConfiguration(
            containerName: "Model",
            storeType: NSInMemoryStoreType))
    
    let folderDAO = try! CoreDataDAO(
        CDFolderTranslator(),
        configuration: CoreDataConfiguration(
            containerName: "Model",
            storeType: NSInMemoryStoreType))
    
    
    func testPersistMessage() {
        let message = Message(entityId: "abc", text: "text")
        let folder = Folder(entityId: "fld", name: "folder", messages: [])
        
        do {
            try messagesDAO.persist(message)
            try folderDAO.persist(folder)
        } catch _ {
            XCTFail("Persist message is failed")
        }
        
        XCTAssertEqual(message, messagesDAO.read(message.entityId))
        XCTAssertEqual(folder, folderDAO.read(folder.entityId))
    }
    
}
