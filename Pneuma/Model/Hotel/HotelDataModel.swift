//
//  HotelDataModel.swift
//  Pneuma
//
//  Created by MacBook Pro on 25/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

struct HotelBookRequestModel: Codable {
    var user_id: String?
    var name: String?
    var address: String?
    var room_type: String?
    var price: String?
    var image: String?
    var features: [String]?
    var check_in: String?
    var check_out: String?
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case name = "name"
        case address = "address"
        case room_type = "room_type"
        case price = "price"
        case image = "image"
        case features = "features"
        case check_in = "check_in"
        case check_out = "check_out"
    }
}

// MARK: - LoginDataModel
struct HotelBookResponseModel: Codable {
    var statusCode: Int?
    var message: String?
}
