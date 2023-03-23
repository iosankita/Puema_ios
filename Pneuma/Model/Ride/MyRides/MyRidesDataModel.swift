//
//  MyRidesDataModel.swift
//  Pneuma
//
//  Created by Jatin on 16/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class MyRidesTableDataSourceModel: NSObject {
    var listArray = [RideModel]()
}

struct GetRideBookingsResponseModel: Codable {
    var statusCode: Int?
    var data: [RideModel]?
    //var message: String?
    //var token: String?
}


