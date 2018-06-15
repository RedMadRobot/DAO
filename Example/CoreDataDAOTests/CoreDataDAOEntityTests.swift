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
    
    let dao = try! CoreDataDAO(
        CDEntityTranslator(),
        configuration: CoreDataConfiguration(
            containerName: "Model",
            storeType: NSInMemoryStoreType))
    
    
    func testReadById() {
        let entity = Entity(entityId: "2")
        
        do {
            try dao.persist(entity)
        } catch _ {
            XCTFail("Read by id is failed")
        }
        
        
        if let savedEntity = dao.read("2") {
            XCTAssertEqual(savedEntity.entityId, entity.entityId)
        } else {
            XCTFail("Read by id is failed")
        }
    }
    
    
    func testAsyncReadById() {
        let entity = Entity(entityId: "2_back")
        let exp = expectation(description: "")
        
        DispatchQueue.global().async {
            do {
                try self.dao.persist(entity)
            } catch _ {
                XCTFail("Async read by id is failed")
            }
            
            
            DispatchQueue.global().async {
                if let savedEntity = self.dao.read("2_back") {
                    XCTAssertEqual(savedEntity.entityId, entity.entityId)
                } else {
                    XCTFail("Async read by id is failed")
                }
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5) { error in
            if error != nil {
                XCTFail("Async read by id is failed")
            }
            XCTAssert(true)
        }
    }
    
    
    func testPersist() {
        let entity = Entity(entityId: "1")
        do {
            try dao.persist(entity)
        } catch _ {
            XCTFail("Persist is failed")
        }
        
        
        XCTAssert(true)
    }
    
    
    func testPersistAll() {
        let firstEntity = Entity(entityId: "2")
        let secondEntity = Entity(entityId: "3")
        
        do {
            try dao.persist([firstEntity, secondEntity])
        } catch _ {
            XCTFail("Persist All is failed")
        }
        
        XCTAssert(true)
    }
    
    
    func testAsyncPersist() {
        let exp = expectation(description: "")
        
        DispatchQueue.global().async {
            let entity = Entity(entityId: "1_back")
            
            do {
                try self.dao.persist(entity)
            } catch _ {
                XCTFail("Saving entity in background is failed")
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if error != nil {
                XCTFail("Saving entity in background is failed")
            }
            XCTAssert(true)
        }
    }

    
    func testEraseById() {
        let entity = Entity(entityId: "3")
        
        do {
            try dao.persist(entity)
            try dao.erase("3")
        } catch _ {
            XCTFail("Erase is failed")
        }
    
        XCTAssert(true)
    }
    
    
    func testAsyncEraseById() {
        let entity = Entity(entityId: "2_back")
        
        do {
            try dao.persist(entity)
        } catch _ {
            XCTFail("Async erase by id is failed")
        }
        
        
        let exp = expectation(description: "")
        
        DispatchQueue.global().async {
            do {
                try self.dao.erase("2_back")
            } catch _ {
                XCTFail("Async erase by id is failed")
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if error != nil {
                XCTFail("Async erase by id is failed")
            }
            XCTAssert(true)
        }
    }
    
}
