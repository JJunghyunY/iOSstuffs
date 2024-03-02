//
//  MockSignupWebservice.swift
//  TestingTests
//
//  Created by Junyoo on 3/2/24.
//

import Foundation
@testable import Testing

final class MockSignupWebservice: SignupWebServiceProtocol {
    var isSignupMethodCalled: Bool = false
    var shouldReturnError: Bool = false

    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        isSignupMethodCalled = true
        
        if shouldReturnError {
            completionHandler(nil, SignupError.failedRequest(description: "signup failed"))
        } else {
            let responseModel = SignupResponseModel(status: "ok")
            completionHandler(responseModel, nil)
        }
    }
}
