//
//  SearchFlightsDataModel.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
import UIKit

class SearchFlightsTableDataSourceModel: NSObject {
    var listArray = [SearchFlightsDataModel]()
    var listArray2 = [SearchResultModel]()
    var selectSection : Int = -1
    var arrAirlineInfoModel: [AirlineInfoModel]? = []
    var arrSearchCityData : [SearchCityData] = []
    var limit = 10
    var offset = 1
    var totalPage = 1
    var isReturn = false
    var isRoundTrip = false
}

struct SearchFlightsDataModel {
    var title: String
    var stopsCount: Int = 1
    var imageName: String?
    var logo: UIImage? {
        if let name = self.imageName {
            return UIImage(named: name)
        }
        return nil
    }
}

struct FlightSearchResponse: Codable {
    let status: Bool?
    let data: [FlightSearchResponseData]?
}

//struct FlightSearchResponseData: Codable

// MARK: - SearchCity
struct SearchCity: Codable {
    var status: Bool?
    var data: [SearchCityData]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

// MARK: - Datum
struct SearchCityData: Codable {
    var AirportName: String?
    var City: String?
    var Country: String?
    var id : Int?
    var AirportCode : String?
//    var countryName: String?
//    var category: String?
//
//    var state : String?
//    var stateName : String?
//    var dataset: String?
//    var datasource: String?
//    var confidenceFactor : StringInt?
//    var latitude : String?
//    var longitude : String?
//
//    var ranking: Int?
 

}

