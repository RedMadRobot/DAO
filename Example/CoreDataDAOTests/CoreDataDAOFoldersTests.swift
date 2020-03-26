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
    
    private var dao: CoreDataDAO<Folder, CDFolder>!
    
    override func setUp() {
        super.setUp()
        
        let translator = CDFolderTranslator()
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
    
    func testPersistMessages() {
        let message1 = Message(entityId: "abc", text: "text1")
        let message2 = Message(entityId: "bcc", text: "text2")
        let folder = Folder(entityId: "fld", name: "Home", messages: [message1, message2])
        
        XCTAssertNoThrow(try dao.persist(folder), "Persist folder is failed")
        XCTAssertEqual(dao.read(folder.entityId)?.messages.count, folder.messages.count)
    }
    
}
