//
//  CurrencyFormatterTests.swift
//  BankeyTests
//
//  Created by Junyoo on 3/17/24.
//

import XCTest
@testable import Bankey

class CurrencyFormatterTests: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testShouldBeVisible() throws {
        let sut = formatter.breakIntoDollarsAndCents(123456.78)
        
        XCTAssertEqual(sut.0, "123,456")
        XCTAssertEqual(sut.1, "78")
    }
    
    func testDollarFormatted() throws {
        let sut = formatter.dollarsFormatted(123.45)
        
        XCTAssertEqual(sut, "$123.45")
    }
    
    func testZeroDollarsFormatted() throws {
        let sut = formatter.dollarsFormatted(0.00)

        XCTAssertEqual(sut, "$0.00")
    }
}
