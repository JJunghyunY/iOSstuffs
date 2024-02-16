//
//  TestingNoSetupTests.swift
//  TestingNoSetupTests
//
//  Created by Junyoo on 2/16/24.
//

import XCTest
import CoreData

@testable import TestingNoSetup

final class TestingNoSetupTests: XCTestCase {
    
    var persistenceController: PersistenceController!
    
    override func setUpWithError() throws {
        super.setUp()
        persistenceController = PersistenceController(inMemory: true)
    }

    override func tearDownWithError() throws {
        persistenceController = nil
        tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
