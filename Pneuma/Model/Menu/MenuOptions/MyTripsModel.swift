//
//  MyTripsModel.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation


class TripModel : Codable {
    var id: Int?
    var user_id: Int?
    var origin: String?
    var departure_date: String?
    var arrival_date: String?
    var adults: Int?
    var children: Int?
    var infants: Int?
    var cabin_class: String?
    var payment_method_id: Int?
    var total_payment: String?
    var destination: String?
    var estimated_time: String?
    var flight_no: String?
    var airline: String?
    var created_at: String?
    var updated_at: String?
    
}

class MyTripsDataSourceModel: NSObject {
    var listArray = [TripModel]()
    
}

struct MyTripsResponseModel: Codable {
    var statusCode: Int?
    var data: [TripModel]?
    //var message: String?
    //var token: String?
}
