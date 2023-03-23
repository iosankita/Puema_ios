//
//  UserModel.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import Foundation

// MARK: - DataClass
class UserModel: Codable {
    var id: Int?
    var currency_id: Int?
    var name, email: String?
    var is_social: Int?
    var phone: String?
    var social_id: String?
    var social_type: String?
    var emailVerifiedAt: String?
    var created_at: String?
    var updated_at: String?
    var notify_via: String?
    var nationality: String?
    var passport_issue_date: String?
    var passport_expiry_date: String?
    var passport_country_code: String?
    var passport_number: String?
    var passport_citizenship_number: String?
    var currency: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case currency_id = "currency_id"
        case name = "name"
        case email = "email"
        case phone = "phone"
        case is_social = "is_social"
        case social_id = "social_id"
        case social_type = "social_type"
        case emailVerifiedAt = "email_verified_at"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case notify_via = "notify_via"
        case nationality = "nationality"
        case passport_issue_date = "passport_issue_date"
        case passport_expiry_date = "passport_expiry_date"
        case passport_country_code = "passport_country_code"
        case passport_number = "passport_number"
        case passport_citizenship_number = "passport_citizenship_number"
        case currency = "currency"
        
    }
}
