//
//  RideModel.swift
//  Pneuma
//
//  Created by MacBook Pro on 25/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class RideModel: Codable {
    var id: Int?
    var user_id: Int?
    var payment_method_id: Int?
    var pickup_location, drop_location: String?
    var pickup_time, drop_time : String?
    var rider_name: String?
    var price: Int?
    var rider_image: String?
    var rider_phone: String?
    var rider_rating: Float?
    var created_at: String?
    var updated_at: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user_id = "user_id"
        case payment_method_id = "payment_method_id"
        case pickup_location = "pickup_location"
        case drop_location = "drop_location"
        case pickup_time = "pickup_time"
        case drop_time = "drop_time"
        case rider_name = "rider_name"
        case rider_image = "rider_image"
        case price = "price"
        case rider_phone = "rider_phone"
        case rider_rating = "rider_rating"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
}
