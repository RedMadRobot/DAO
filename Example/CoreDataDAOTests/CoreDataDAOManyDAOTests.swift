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
    
    private var messagesDAO: CoreDataDAO<CDMessage, Message>!
    private var folderDAO: CoreDataDAO<CDFolder, Folder>!
    
    override func setUp() {
        super.setUp()
        
        let configuration = CoreDataConfiguration(
            containerName: "Model",
            storeType: NSInMemoryStoreType
        )
        
        let messageTranslator = CDMessageTranslator()
        messagesDAO = try! CoreDataDAO(
            messageTranslator,
            configuration: configuration
        )
        
        let folderTranslator = CDFolderTranslator()
        folderDAO = try! CoreDataDAO(
            folderTranslator,
            configuration: configuration
        )
    }
    
    override func tearDown() {
        super.tearDown()
        
        try! messagesDAO.erase()
        try! folderDAO.erase()
        
        messagesDAO = nil
        folderDAO = nil
    }
    
    func testPersistMessage() {
        let message = Message(entityId: "abc", text: "text")
        let folder = Folder(entityId: "fld", name: "folder", messages: [])
        
        XCTAssertNoThrow(try messagesDAO.persist(message), "Persist message is failed")
        XCTAssertNoThrow(try folderDAO.persist(folder), "Persist message is failed")
        XCTAssertEqual(message, messagesDAO.read(message.entityId))
        XCTAssertEqual(folder, folderDAO.read(folder.entityId))
    }
    
}
