//
//  MockSignupModeValidator.swift
//  TestingTests
//
//  Created by Junyoo on 3/2/24.
//

import Foundation
@testable import Testing

final class MockSignupModeValidator: SignupModelValidatorProtocol {
    
    var isfirstNameValidated: Bool = false
    var isLastNAmeValidated: Bool = false
    var isEmailFormatValidated: Bool = false
    var isPasswordValidated: Bool = false
    var isPasswordEqualityValidated: Bool = false
    
    func isFirstNameValid(firstName: String) -> Bool {
        isfirstNameValidated = true
        return isfirstNameValidated
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        isLastNAmeValidated = true
        return isLastNAmeValidated
    }
    
    func isValidEmailFormat(email: String) -> Bool {
        isEmailFormatValidated = true
        return isEmailFormatValidated
    }
    
    func isPasswordValid(password: String) -> Bool {
        isPasswordValidated = true
        return isPasswordValidated
    }
    
    func doPasswordsMatch(password: String, repeatPassword: String) -> Bool {
        isPasswordEqualityValidated = true
        return isPasswordEqualityValidated
    }
}
