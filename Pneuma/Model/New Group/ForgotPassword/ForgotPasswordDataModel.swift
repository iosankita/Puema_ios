//
//  ForgotPasswordDataModel.swift
//  Pneuma
//
//  Created by iTechnolabs on 19/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

struct ForgotPasswordRequestModel: Codable {
    var email : String?
}

// MARK: - LoginDataModel
struct ForgotPasswordResponseModel: Codable {
    var statusCode: Int?
    var data: ForgotPasswordData?
    var message: String?
}

// MARK: - DataClass
struct ForgotPasswordData: Codable {
    var userID: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
