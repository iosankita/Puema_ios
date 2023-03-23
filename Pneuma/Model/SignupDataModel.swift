//
//  SignupDataModel.swift
//  Pneuma
//
//  Created by iTechnolabs on 19/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

struct SignupRequestModel: Codable {
     var name: String?
     var email: String?
     var password: String?
     var password_confirmation: String?
    
}

// MARK: - LoginDataModel
struct SignupResponseModel: Codable {
    var status: Bool?
    var data: UserModel?
    var message: String?
    var token: String?
}
