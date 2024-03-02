//
//  SignupViewDelegateProtocol.swift
//  Testing
//
//  Created by Junyoo on 3/2/24.
//

import Foundation

protocol SignupViewDelegateProtocol: AnyObject {
    func successfullSignup()
    func errorHandler(error: SignupError)
}
