//
//  LoginDataModel.swift
//  Pneuma
//
//  Created by Jatin on 25/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

// MARK: - LoginDataModel
struct LoginDataModel: Codable {
    var statusCode: Int?
    var data: UserModel?
    var message: String?
}

struct LoginRequestModel: Codable {
      var email: String?
      var password: String?
}

// MARK: - LoginDataModel
struct LoginResponseModel: Codable {
    var statusCode: Int?
    var data: UserModel?
    var message: String?
    var token: String?
}

