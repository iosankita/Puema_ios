//
//  RideDataModel.swift
//  Pneuma
//
//  Created by MacBook Pro on 25/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

struct RideBookRequestModel: Codable {
    var user_id: Int?
    var payment_method_id: Int?
    var pickup_location, drop_location: String?
    var pickup_time, drop_time : String?
    var rating: Float?
    var price: Int?
    var rider : RiderModel?

    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case payment_method_id = "payment_method_id"
        case pickup_location = "pickup_location"
        case drop_location = "drop_location"
        case pickup_time = "pickup_time"
        case drop_time = "drop_time"
        case rating = "rating"
        case price = "price"
        case rider = "rider"
    }
}

struct RiderModel : Codable {
    var unique_id : Int?
    var name : String?
    var phone : String?
    var email : String?
    var image : String?
    enum CodingKeys: String, CodingKey {
        case unique_id = "unique_id"
        case name = "name"
        case phone = "phone"
        case email = "email"
        case image = "image"
    }
}

// MARK: - LoginDataModel
struct RideBookResponseModel: Codable {
    var statusCode: Int?
    var message: String?
}
