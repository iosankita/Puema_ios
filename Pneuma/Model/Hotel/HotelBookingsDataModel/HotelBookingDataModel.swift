//
//  HotelBookingDataModel.swift
//  Pneuma
//
//  Created by MacBook Pro on 27/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

struct GetHotelBookingsResponseModel: Codable {
    var statusCode: Int?
    var data: [HotelModel]?
    //var message: String?
    //var token: String?
}


class HotelModel : Codable {
    var id: Int?
    var user_id: Int?
    var name: String?
    var image: String?
    var address: String?
    var room_type: String?
    var price: Int?
    var check_in: String?
    var check_out: String?
    var created_at: String?
    var updated_at: String?
    var features: [FeatureModel]?
    
}

class FeatureModel : Codable {
    var id: Int?
    var hotel_id: Int?
    var name: String?
    var created_at: String?
    var updated_at: String?
}

class HotelBookingTableDataSourceModel: NSObject {
    var listArray = [HotelModel]()
}
