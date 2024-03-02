//
//  SignupFormRequestModel.swift
//  Testing
//
//  Created by Junyoo on 3/2/24.
//

import Foundation

struct SignupFormRequestModel: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
