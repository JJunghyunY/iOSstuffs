//
//  SignupViewControllerTests.swift
//  TestingTests
//
//  Created by Junyoo on 3/14/24.
//

import XCTest
@testable import Testing

final class SignupViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut: SignupViewController!

    override func setUpWithError() throws {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "SignupViewController") as? SignupViewController
        sut?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        storyboard = nil
        sut = nil
    }
    
    func testSignupViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        let firstNameTextField = try XCTUnwrap(sut?.firstNameTextField, "The firstNameTextField is not connected with IBOutlet")
        let lastNameTextField = try XCTUnwrap(sut?.lastNameTextField, "The lastNameTextField is not connected with IBOutlet")
        let emailTextField = try XCTUnwrap(sut?.emailTextField, "The emailTextField is not connected with IBOutlet")
        let passwordTextField = try XCTUnwrap(sut?.passwordTextField, "The passwordTextField is not connected with IBOutlet")
        let repeatPasswordTextField = try XCTUnwrap(sut?.repeatPasswordTextField, "The repeatPasswordTextField is not connected with IBOutlet")
        
        XCTAssertEqual(firstNameTextField.text, "", "First name text field was not empty when the view")
        XCTAssertEqual(lastNameTextField.text, "", "Last name text field was not empty when the view")
        XCTAssertEqual(emailTextField.text, "", "Email text field was not empty when the view")
        XCTAssertEqual(passwordTextField.text, "", "Password field was not empty when the view")
        XCTAssertEqual(repeatPasswordTextField.text, "", "Repeat password text field was not empty when the view")
    }
    
    func testViewController_WhenCreated_HasSignupButtonAndAction() throws {
        // Arrange
        let signupButton: UIButton = try XCTUnwrap(sut.signupButton, "Signup button doesn not have referencing IBOutlet")
        
        // Act
        let signupButtonAction = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "Signup button does not have any actions assigned to it")
        
        // Assert
        XCTAssertEqual(signupButtonAction.count, 1)
        XCTAssertEqual(signupButtonAction.first, "signupButtonTapped:", "No action with a signupButtonTapped")
    }
    
    func testViewController_WhenSignupButtonTapped_InvokedSignupProcess() {
        // Arrange
        let mockSignupModelValidator = MockSignupModelValidator()
        let mockSignupWebservice = MockSignupWebservice()
        let mockSignupViewDelegate = MockSignupViewDelegate()
        
        let mockSignupPresenter = MockSignupPresenter(formModelValidator: mockSignupModelValidator,
                                                      webservice: mockSignupWebservice,
                                                      delegate: mockSignupViewDelegate)
        sut.signupPresenter = mockSignupPresenter
        
        // Act
        sut.signupButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertTrue(mockSignupPresenter.processUserSignupCalled, "The ProcessUserSignup() method was not called on a Presenter object when the signup button was tapped in a SignupViewController")
    }
    
}
