//
//  SignupFormModelValidatorTest.swift
//  TestingTests
//
//  Created by Junyoo on 3/1/24.
//

import XCTest
@testable import Testing

final class SignupFormModelValidatorTest: XCTestCase {

    var sut: SignupFormModelValidator!

    override func setUpWithError() throws {
        sut = SignupFormModelValidator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSignupFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Jun")
        
        XCTAssertTrue(isFirstNameValid, "'isFirstNameValid' should return True for valid name")
    }
    
    func testSignupFormModelValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        let isFirstNameValid = sut.isFirstNameValid(firstName: "S")
         
        XCTAssertFalse(isFirstNameValid, "'isFirstNameValid should return False for short name that is shorter than \(SignupConstants.firstNameMinLength) character")
    }
    
    func testSignupFormModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFlase() {
        let isFirstNameValid = sut.isFirstNameValid(firstName: "slkdfjsldfijwelifjwweifjwef")
        
        XCTAssertFalse(isFirstNameValid, "'isFirstNameValid should return False for long name that is longer than \(SignupConstants.firstNameMaxLength) character'")
    }
    
    func testSignupFormModelValidator_WhenEqualPasswordProvided_ShouldReturnTrue() {
        let doPasswordMatch = sut.doPasswordsMatch(password: "1234qwer", repeatPassword: "1234qwer")
        
        XCTAssertTrue(doPasswordMatch, "doPasswordMatch should return True for matching passwords")
    }
    
    func testSignupFormModelValidator_WhenNotMathingPasswordProvided_ShouldReturnFalse() {
        let doPasswordMatch = sut.doPasswordsMatch(password: "qwer1234", repeatPassword: "1234qwer")
        
        XCTAssertFalse(doPasswordMatch, "doPasswordMatch should return False for not-matched passwords")
    }
}
