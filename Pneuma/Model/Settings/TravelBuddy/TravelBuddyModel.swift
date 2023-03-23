//
//  TravelBuddyModel.swift
//  Pneuma
//
//  Created by Chitra on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation



struct StoreTravelBuddyRequestModel: Codable {
    //var user_id: Int?
    //var first_name, last_name, middle_name: String?
    var name: String?
    //var dob: String?
    var email: String?
}

struct StoreTravelBuddyResponseModel: Codable {
    var status: Bool?
    var message: String?
}

struct GetTravelBuddiesResponseModel: Codable {
    var statusCode: Int?
    var data: [TravelBuddyModel]?
    //var message: String?
    //var token: String?
}

class TravelBuddyDataSourceModel: NSObject {
    var listArray = [TravelBuddyModel]()
}

class TravelBuddyModel : Codable {
    var user_id: Int?
    var first_name, last_name, middle_name: String?
    var name: String?
    var email: String?
    //var dob: String?

    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case middle_name = "middle_name"
        case name
        case email
        //case dob = "dob"
    }
}
