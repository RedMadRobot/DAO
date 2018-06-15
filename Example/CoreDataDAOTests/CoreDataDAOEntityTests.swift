//
//  CoreDataDAOEntityTests.swift
//  DAO
//
//  Created by Ivan Vavilov on 4/25/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import XCTest
import DAO
import CoreData
@testable import DAO_Example


final class CoreDataDAOEntityTests: XCTestCase {
    
    private var dao: CoreDataDAO<CDEntity, Entity>!
    
    override func setUp() {
        super.setUp()
        
        let translator = CDEntityTranslator()
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
        
        dao = nil
    }
    
    func testReadById() {
        let entity = Entity(entityId: "2")
        
        XCTAssertNoThrow(try dao.persist(entity), "Read by id is failed")
        XCTAssertEqual(dao.read("2")?.entityId, entity.entityId, "Read by id is failed")
    }
    
    
    func testAsyncReadById() {
        let entity = Entity(entityId: "2_back")
        let exp = expectation(description: "")
        
        DispatchQueue.global().async {

            XCTAssertNotNil(try? self.dao.persist(entity), "Async read by id is failed")
            
            DispatchQueue.global().async {
                XCTAssertEqual(self.dao.read("2_back")?.entityId, entity.entityId, "Async read by id is failed")
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5)
    }
    
    
    func testPersist() {
        let entity = Entity(entityId: "1")
        
        XCTAssertNoThrow(try dao.persist(entity), "Persist is failed")
    }
    
    
    func testPersistAll() {
        let firstEntity = Entity(entityId: "2")
        let secondEntity = Entity(entityId: "3")
        
        XCTAssertNoThrow(try dao.persist([firstEntity, secondEntity]), "Persist All is failed")
    }
    
    
    func testAsyncPersist() {
        let entity = Entity(entityId: "1_back")
        let exp = expectation(description: "")
        
        DispatchQueue.global().async {
            XCTAssertNotNil(try? self.dao.persist(entity), "Saving entity in background is failed")
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }

    
    func testEraseById() {
        let entity = Entity(entityId: "3")
        
        XCTAssertNoThrow(try dao.persist(entity), "Erase is failed")
        XCTAssertNoThrow(try dao.erase("3"), "Erase is failed")
    }
    
    
    func testAsyncEraseById() {
        let entity = Entity(entityId: "2_back")
        
        XCTAssertNoThrow(try dao.persist(entity), "Async erase by id is failed")
        
        let exp = expectation(description: "")
        DispatchQueue.global().async {
            XCTAssertNotNil(try? self.dao.erase("2_back"), "Async erase by id is failed")
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
}
