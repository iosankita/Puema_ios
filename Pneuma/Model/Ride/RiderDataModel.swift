//
//  RiderDataModel.swift
//  Pneuma
//
//  Created by MacBook Pro on 31/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

struct RiderReportRequestModel: Codable {
    var rider_id: Int?
    var title: String?
    var description: String?
}

struct RiderReportResponseModel: Codable {
    var message: String?
}

struct RiderRateRequestModel: Codable {
    var rider_id: Int?
    var rating: Float?
    var description: String?
}

struct RiderRateResponseModel: Codable {
    var message: String?
}
