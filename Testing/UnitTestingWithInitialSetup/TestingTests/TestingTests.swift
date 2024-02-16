//
//  TestingTests.swift
//  TestingTests
//
//  Created by Junyoo on 2/15/24.
//

import XCTest
import CoreData
@testable import Testing

final class TestingTests: XCTestCase {
    
    var persistenceController: PersistenceController!
    var viewContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        super.setUp()
        persistenceController = PersistenceController(inMemory: true)
        viewContext = persistenceController.container.viewContext
    }

    override func tearDownWithError() throws {
        persistenceController = nil
        viewContext = nil
        super.tearDown()
    }

    func testAddItem() throws {
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
        try viewContext.save()
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let results = try viewContext.fetch(fetchRequest)
        
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first, newItem)
    }
    
    func testDeleteItem() throws {
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
        try viewContext.save()
        
        viewContext.delete(newItem)
        try viewContext.save()
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let results = try viewContext.fetch(fetchRequest)
        
        XCTAssertTrue(results.isEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
