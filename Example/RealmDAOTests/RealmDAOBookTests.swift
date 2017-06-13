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


class RealmDAOBookTests: XCTestCase {
    
    let dao = RealmDAO(RLMBookTranslator())
    
    
    func testPersist() {
        let book = Book(entityId: "book1", name: "Swift", authors: ["Chris Lattner"],
                        dates: [Date(timeIntervalSince1970: 1000000)],
                        pages: [100, 200], attachments: [Data()])
        
        do {
            try dao.persist(book)
        } catch {
            XCTFail("Persist is failed")
        }
        
        if let savedBook = dao.read(book.entityId) {
            XCTAssertEqual(book, savedBook)
            XCTAssertFalse(savedBook.authors.isEmpty)
            XCTAssertEqual(savedBook.authors.first, "Chris Lattner")
            XCTAssertFalse(savedBook.dates.isEmpty)
            XCTAssertFalse(savedBook.pages.isEmpty)
            XCTAssertEqual(savedBook.pages.count, 2)
            XCTAssertFalse(savedBook.attachments.isEmpty)
        } else {
            XCTFail("Persist is failed")
        }
    }
    
}
