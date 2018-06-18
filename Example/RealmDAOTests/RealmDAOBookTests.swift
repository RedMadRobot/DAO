//
//  RealmDAOBookTests.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/17/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import XCTest
import DAO
@testable import DAO_Example


final class RealmDAOBookTests: XCTestCase {
    
    private var dao: RealmDAO<Book, DBBook>!
    
    override func setUp() {
        super.setUp()
        
        dao = RealmDAO(RLMBookTranslator())
    }
    
    override func tearDown() {
        super.tearDown()
        
        try! dao.erase()
        dao = nil
    }
    
    func testPersist() {
        let book = Book(
            entityId: "book1",
            name: "Swift",
            authors: ["Chris Lattner"],
            dates: [Date(timeIntervalSince1970: 1000000)],
            pages: [100, 200],
            attachments: [Data()]
        )
        
        XCTAssertNoThrow(try dao.persist(book), "Persist is failed")
        XCTAssertEqual(book, dao.read(book.entityId), "Persist is failed")
        XCTAssertFalse((dao.read(book.entityId)?.authors.isEmpty) == true, "Persist is failed")
        XCTAssertEqual(dao.read(book.entityId)?.authors.first, "Chris Lattner", "Persist is failed")
        XCTAssertFalse((dao.read(book.entityId)?.dates.isEmpty) == true, "Persist is failed")
        XCTAssertFalse((dao.read(book.entityId)?.pages.isEmpty) == true, "Persist is failed")
        XCTAssertEqual(dao.read(book.entityId)?.pages.count, 2, "Persist is failed")
        XCTAssertFalse((dao.read(book.entityId)?.attachments.isEmpty) == true, "Persist is failed")
    }
    
}
