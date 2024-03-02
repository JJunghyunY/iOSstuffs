//
//  SignupPresenterTests.swift
//  TestingTests
//
//  Created by Junyoo on 3/2/24.
//

import XCTest
@testable import Testing

final class SignupPresenterTests: XCTestCase {
    var signupFormModel: SignupFormModel!
    var mockSignupModelValidator: MockSignupModeValidator!
    var mockSignupWebService: MockSignupWebservice!
    var sut: SignupPresenter!
    var mockSignupViewDelegate: MockSignupViewDelegate!
    
    override func setUpWithError() throws {
        signupFormModel = SignupFormModel(firstName: "jun",
                                          lastName: "yoo",
                                          email: "test@test.com",
                                          password: "12345",
                                          repeatPassword: "12345")
        mockSignupModelValidator = MockSignupModeValidator()
        mockSignupWebService = MockSignupWebservice()
        mockSignupViewDelegate = MockSignupViewDelegate()
        sut = SignupPresenter(formModelValidator: mockSignupModelValidator,
                              webservice: mockSignupWebService,
                              delegate: mockSignupViewDelegate
        )
    }
    
    override func tearDownWithError() throws {
        signupFormModel = nil
        mockSignupModelValidator = nil
        mockSignupWebService = nil
        mockSignupViewDelegate = nil
        sut = nil
    }
    
    func testSignupPresenter_WhenInformationProvided_WillValidateEachProperty() {
        sut.processUserSignup(formModel: signupFormModel)
        
        XCTAssertTrue(mockSignupModelValidator.isfirstNameValidated, "First name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isLastNAmeValidated, "Last name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailFormatValidated, "Email was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValidated, "Password was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordEqualityValidated, "RepeatPassword was not validated")
    }
    
    func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod() {
        sut.processUserSignup(formModel: signupFormModel)
        
        XCTAssertTrue(mockSignupWebService.isSignupMethodCalled, "signup method was not called in SignupWebService")
    }
    
    func testSignupPresenter_WhenSignupOperationSuccessful_CallSuccessOnViewDelegate() {
        let myExpectation = expectation(description: "Expected the successfulSignup method to be called")
        mockSignupViewDelegate.expectation = myExpectation
        
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [myExpectation], timeout: 5)
        
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 1, "successfulsignup method was called more than one time")
    }
    
    func testSignupPresenter_WhenSignupOperationFails_ShouldCallErrorOnDelegate() {
        let errorHandlerExpectation = expectation(description: "expected the errorHandler method to be called")
        mockSignupViewDelegate.expectation = errorHandlerExpectation
        mockSignupWebService.shouldReturnError = true
        
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [errorHandlerExpectation], timeout: 5)
        
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 0)
        XCTAssertEqual(mockSignupViewDelegate.errorHandlerCounter, 1)
        XCTAssertNil(mockSignupViewDelegate.signupError)
    }
}
