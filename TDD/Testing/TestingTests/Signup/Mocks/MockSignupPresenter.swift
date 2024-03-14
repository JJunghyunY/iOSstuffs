//
//  MockSignupPresenter.swift
//  TestingTests
//
//  Created by Junyoo on 3/14/24.
//

import Foundation
@testable import Testing

class MockSignupPresenter: SignupPresenterProtocol {
    var processUserSignupCalled: Bool = false

    required init(formModelValidator: Testing.SignupModelValidatorProtocol, webservice: Testing.SignupWebServiceProtocol, delegate: Testing.SignupViewDelegateProtocol) {
        
    }
    
    func processUserSignup(formModel: Testing.SignupFormModel) {
        processUserSignupCalled = true
    }
}
