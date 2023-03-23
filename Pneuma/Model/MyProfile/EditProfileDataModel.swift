//
//  EditProfileDataModel.swift
//  Pneuma
//
//  Created by MacBook Pro on 25/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

struct EditNameRequestModel: Codable {
    var name: String?
}

struct EditNameResponseModel: Codable {
    var statusCode: Int?
    var message: String?
}
struct EditPhoneRequestModel: Codable {
    var phone: String?
}

struct EditPhoneResponseModel: Codable {
    var statusCode: Int?
    var message: String?
}
struct EditEmailRequestModel: Codable {
    var email: String?
    var password: String?
    
}

struct EditEmailResponseModel: Codable {
    var statusCode: Int?
    var message: String?
}

struct EditPasswordRequestModel: Codable {
    var old_password: String?
    var new_password: String?
    var confirm_password: String?
    
}

struct EditPasswordResponseModel: Codable {
    var statusCode: Int?
    var message: String?
}

struct EditPassportRequestModel: Codable {
    var nationality: String?
    var passport_issue_date: String?
    var passport_expiry_date: String?
    var passport_country_code: String?
    var passport_number: String?
    var passport_citizenship_number: String?
}

struct EditPassportResponseModel: Codable {
    var message: String?
}
