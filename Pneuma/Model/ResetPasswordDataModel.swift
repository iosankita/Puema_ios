//
//  ResetPasswordDataModel.swift
//  Pneuma
//
//  Created by iTechnolabs on 19/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

struct ResetPasswordRequestModel: Codable {
    var user_id: String?
    var reset_password_otp: String?
    var password: String?
    var confirm_password: String?
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case reset_password_otp = "reset_password_otp"
        case password = "password"
        case confirm_password = "confirm_password"
    }
    
}
struct CommonResponseModel: Codable {
    var statusCode: Int
    var message: String?
}
