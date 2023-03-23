//
//  ChooseAddressDataModel.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
import UIKit

enum ChooseAddressTypeEnum {
    case origin
    case destination
    case pickupAddress
    case dropoffAddress
    
    var title: String {
        switch self {
        
        case .origin:
            return "Select Origin"
        case .destination:
            return "Select Destination"
        case .pickupAddress:
            return "Select Pickup Address"
        case .dropoffAddress:
            return "Select Drop-off Address"
        }
    }
    
    var description: String {
        switch self {
        
        case .origin, .pickupAddress:
            return "Recent Origins"
        case .destination, .dropoffAddress:
            return "Recent Destinations"
        }
    }
    
    var addressImage: UIImage {
        switch self {
        
        case .origin:
            return UIImage(named: "planeUpPurple")!
        case .destination:
            return UIImage(named: "planeDownPurple")!
        case .pickupAddress, .dropoffAddress:
            return UIImage(named: "PickUp")!
        }
    }
    
    var isHideSelectLocationOnMapView: Bool {
        switch self {
        case .origin, .destination:
            return true
        case .pickupAddress, .dropoffAddress:
            return false
        }
    }
}

class ChooseAddressTableDataSourceModel: NSObject {
    var listArray = [AirportsList]()
    var listArray2 = [SearchCityData]()
    var VM: ChooseAddressVM?
}

struct ChooseAddressDataModel {
    var title: String
    var subtitle: String?
    var image: UIImage?
}

// MARK: - AirportsSearch
struct AirportsSearchResponseModel: Codable {
    let meta: Meta?
    let data: [AirportsList]?
}

// MARK: - Airports List
struct AirportsList: Codable {
    let type, subType, name, detailedName: String?
    let timeZoneOffset, iataCode: String?
    let geoCode: GeoCode?
    let address: Address?
    let distance: Distance?
    let analytics: Analytics?
    let relevance: Double?
}

struct recentSearch: Codable {
    let arrival_date, cabin_type, departure_date: String?
    let destination, origin: String?
    let id: Int?
    let children: Int?
    let adults: Int?
}

// MARK: - Address
struct Address: Codable {
    let cityName, cityCode, countryName, countryCode: String?
    let stateCode, regionCode: String?
}

// MARK: - Analytics
struct Analytics: Codable {
    let flights, travelers: Flights?
}

// MARK: - Flights
struct Flights: Codable {
    let score: Int?
}

// MARK: - Distance
struct Distance: Codable {
    let value: Int?
    let unit: String?
}

// MARK: - GeoCode
struct GeoCode: Codable {
    let latitude, longitude: Double?
}

// MARK: - Meta
struct Meta: Codable {
    let count: Int?
    let links: Links?
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, previous, first, last: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previous, first, last
    }
}

struct CustomAirportSearchResponseModel: Codable {
    let meta: Meta?
    let data: [CustomAirportSearchResponse]?
}

struct CustomAirportSearchResponse: Codable {
    var geoCode: GeoCode?
    var iataCode: String?
    var timeZoneOffset: String?
    var type: String?
    var detailedName: String?
    var id: String?
    var subType: String?
    var address: Address?
    var name: String?
    var analytics: Analytics?
}
