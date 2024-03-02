//
//  SignupWebServiceProtocol.swift
//  Testing
//
//  Created by Junyoo on 3/2/24.
//

import Foundation

protocol SignupWebServiceProtocol {
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void)
}
