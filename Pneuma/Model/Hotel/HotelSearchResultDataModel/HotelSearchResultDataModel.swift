//
//  HotelSearchResultDataModel.swift
//  Pneuma
//
//  Created by Jatin on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class HotelSearchResultTableDataSourceModel: NSObject {
    var listArray = [HotelSearchData]()
}

struct HotelSearchResultDataModel {
    var title: String
}

struct RoomDetail {
    var roomName: String?
    var roomBedType: String?
    var roomAmenties: [String]?
    var roomPrice: String?
    var payCurrency: String?

    init(roomName:String?, roomBedType: String?, roomAmenties: [String]?, roomPrice: String?, payCurrency: String?) {
        self.roomName = roomName
        self.roomBedType = roomBedType
        self.roomAmenties = roomAmenties
        self.roomPrice = roomPrice
        self.payCurrency = payCurrency
    }
}

// MARK: - HotelSearchResponse
struct HotelSearchResponse: Codable {
    var status: Bool?
    var data: [HotelSearchData]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

// MARK: - Datum
struct HotelSearchData: Codable {

    var hotelName: String?
    var hotelCode: String?
    var hotelImages: [String]?
    var hotelAddress: String?
    var hotelSabreRating: String?
    var sabreHotelCode: String?
    var hotelContact: HotelContactUnion?
    var hotelDistance: Double?
    var latitude: String?
    var longitude: String?
    var amenities: [String]?
    var rooms: [Room]?

    enum CodingKeys: String, CodingKey {
        case hotelName = "HotelName"
        case hotelCode = "HotelCode"
        case hotelImages = "HotelImages"
        case hotelAddress = "HotelAddress"
        case hotelSabreRating = "HotelSabreRating"
        case sabreHotelCode = "SabreHotelCode"
        case hotelContact = "HotelContact"
        case hotelDistance = "hotelDistance"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case amenities = "Amenities"
        case rooms = "Rooms"
    }
}
//Anki
enum HotelContactUnion: Codable {
    case hotelContactClass(HotelContactClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(HotelContactClass.self) {
            self = .hotelContactClass(x)
            return
        }
        throw DecodingError.typeMismatch(HotelContactUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for HotelContactUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .hotelContactClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - HotelContactClass
struct HotelContactClass: Codable {
    var phone: String?
    var fax: String?

    enum CodingKeys: String, CodingKey {
        case phone = "Phone"
        case fax = "Fax"
    }
}

// MARK: - Room
struct Room: Codable {
    var availableRoomQuantity: AvailableRoomQuantity?
    var rateKey: String?
    var currencyCode: String?
    var roomRate: Double?
    var roomDescription: [String]?
    var roomType: String?

    enum CodingKeys: String, CodingKey {
        case availableRoomQuantity = "availableRoomQuantity"
        case rateKey = "RateKey"
        case currencyCode = "currencyCode"
        case roomRate = "roomRate"
        case roomDescription = "roomDescription"
        case roomType = "roomType"
    }
}

enum AvailableRoomQuantity: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(AvailableRoomQuantity.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AvailableRoomQuantity"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
