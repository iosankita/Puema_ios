//
//  FlightSearchResponse.swift
//  Pneuma
//
//  Created by Infinity S on 05/01/22.
//  Copyright © 2022 Jatin Korat. All rights reserved.
//

import Foundation

struct FlightSearchAnnieResponse: Codable {
    let status: Bool?
    let data: FlightSearchResponseData?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case data
    }
}
// MARK: - FlightSearchResponse
struct FlightSearchResponse2: Codable {
    let data: SearchResult?
    let RecordLimit :Int?
    let RecordOffset :Int?
    let TotalRecords :Int?
    enum CodingKeys: String, CodingKey {
        case data
        case RecordLimit,RecordOffset,TotalRecords
    }
}


struct SearchResult: Codable {
    let SearchResult: [SearchResultModel]?
    enum CodingKeys: String, CodingKey {
        case SearchResult
    }
}
struct SearchResultModel : Codable {
    var AirItinerary : [AirItineraryModel]?
    var AirItineraryPricingInfo : [AirItineraryPricingInfoModel]?
    var TicketingInfo : TicketingInfo?
    var ID : String?
    var DataSource: String?
    
    enum CodingKeys: String, CodingKey {
        case AirItinerary
        case AirItineraryPricingInfo,ID,DataSource
    }
}
struct TicketingInfo :Codable{
    var  TicketType : String?
    var ValidInterline : String?
}
struct AirItineraryPricingInfoModel : Codable {
    let PricingSource : String?
    let PricingSubSource : String?
    let FareReturned :Bool?
    let ItinTotalFare : ItinTotalFare?
let DivideInPartyIndicator:Bool?
    let IsRefundable : Bool?
    let FareBreakdown : [FareBreakdown]?

}
struct ItinTotalFare : Codable{
    let BaseFare : FareModel?
    let EquivFare : FareModel?
    let TotalFare: FareModel?
    let Taxes : TaxesModel?
}
struct TaxesModel: Codable{
    let  Tax :[TaxModel]?
}
struct TaxModel: Codable{
    let TaxCode : String?
    let Amount : StringInt?
    let CurrencyCode : String?
    let DecimalPlaces : StringInt?
    let content : String?
}

struct FareBreakdown: Codable{
    let PassengerTypeQuantity : PassengerTypeQuantity?
    let PassengerFare: PassengerFare?
    var BaggageInfo : [String]?
    let NonRefundableIndicator : Bool?
    let TPA_Extensions : TPA_Extensions?
}
struct TPA_Extensions : Codable{
    let FareCalcLine : FareCalcLine?
   
}
struct FareCalcLine : Codable {
    let Info : String?
}
struct PassengerTypeQuantity : Codable{
    let Code : String?
    let Quantity : Int?
    let PassengerFare : PassengerFare?
}
struct PassengerFare : Codable{
    let BaseFare : FareModel?
    let EquivFare : FareModel?
    let TotalFare : FareModel?
      let Taxes : FareModel?
}

struct FareModel: Codable{
        let DecimalPlaces : StringInt?
        let Amount: Double?
        let CurrencyCode: String?
        enum CodingKeys: String, CodingKey {
            case DecimalPlaces,Amount
            case CurrencyCode
        }
}
struct AirItineraryModel : Codable {
    var ElapsedTime : Int?
    var FlightSegment : [FlightSegment]?
    enum CodingKeys: String, CodingKey {
        case ElapsedTime
        case FlightSegment
    }
}

struct FlightSegment : Codable {
    let ArrivalDetails :AirportDetailsModel?
    let DepartureDetails: AirportDetailsModel?
    let FlightNumber :StringInt?
    let ElapsedTime: Int?
    let DepartureDateTime : String?
    let DepartureTimeZone : StringInt?
    let ArrivalDateTime: String?
    let ArrivalTimeZone : StringInt?
    let OperatingAirline: AirlineModel?
    let MarketingAirline : AirlineModel?
    let MarriageGrp : StringInt?
    let OtherDetails : OtherDetails?
    let SeatsRemaining : SeatsRemaining?
    let ResBookDesigCode : String?
    let StopQuantity : StringInt?
    let eTicketIndicator : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case DepartureDateTime
        case DepartureTimeZone
        case ArrivalDateTime
        case ArrivalTimeZone
        case OperatingAirline, MarketingAirline, ElapsedTime,FlightNumber
        case ArrivalDetails = "ArrivalAirportDetails"
        case DepartureDetails = "DepartureAirportDetails"
        case MarriageGrp
        case OtherDetails
        case ResBookDesigCode
        case StopQuantity,eTicketIndicator,SeatsRemaining
        
        
    }
  
 
}
struct OtherDetails: Codable {
    var CabinType: String?
    var MealCode: String?
   
}
struct SeatsRemaining : Codable{
    var BelowMin: String?
    var Number : String?
    
}
struct AirlineModel : Codable {
    let Code: String?
    let FlightNumber: String?
    let content: String?
    enum CodingKeys: String, CodingKey {
        case Code
        case FlightNumber,content
     }
}
class AirportDetailsModel : Codable {
    var LocationCode: String?
    var LocationName: String?
    let TerminalID :String?
    let content :String?
    
    enum CodingKeys: String, CodingKey {
        case LocationCode
        case LocationName, TerminalID,content
     }
}
// MARK: - Datum
struct FlightSearchResponseData: Codable {
    var flightDict: FlightDict?
    var returnFlightDict: ReturnFlightDict?
    var lastTicketingDate: String?
    var numberOfBookableSeats: Int?
    var fareOption: String?
    var priceBase: String?
    var priceCurrency: String?
    var priceTotal: String?
    var allData: AllData?
    var isExpand : Bool?

    enum CodingKeys: String, CodingKey {
        case flightDict = "flight_dict"
        case returnFlightDict = "return_flight_dict"
        case lastTicketingDate = "lastTicketingDate"
        case numberOfBookableSeats = "numberOfBookableSeats"
        case fareOption = "fareOption"
        case priceBase = "price_base"
        case priceCurrency = "price_currency"
        case priceTotal = "price_total"
        case allData = "all_data"
        case isExpand = "isExpand"
    }

}


// MARK: - Location0
struct Location0: Codable {
    let cityCode, countryCode: String?
}

// MARK: - AllData
struct AllData: Codable {
    var type: String?
    var id: String?
    var source: String?
    var instantTicketingRequired: Bool?
    var nonHomogeneous: Bool?
    var oneWay: Bool?
    var lastTicketingDate: String?
    var numberOfBookableSeats: Int?
    var itineraries: [Itinerary]?
    var price: AllDataPrice?
    var pricingOptions: PricingOptions?
    var validatingAirlineCodes: [String]?
    var travelerPricings: [TravelerPricing]?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case source = "source"
        case instantTicketingRequired = "instantTicketingRequired"
        case nonHomogeneous = "nonHomogeneous"
        case oneWay = "oneWay"
        case lastTicketingDate = "lastTicketingDate"
        case numberOfBookableSeats = "numberOfBookableSeats"
        case itineraries = "itineraries"
        case price = "price"
        case pricingOptions = "pricingOptions"
        case validatingAirlineCodes = "validatingAirlineCodes"
        case travelerPricings = "travelerPricings"
    }
}

// MARK: - Itinerary
struct Itinerary: Codable {
    var duration: String?
    var segments: [Segment]?

    enum CodingKeys: String, CodingKey {
        case duration = "duration"
        case segments = "segments"
    }
}

// MARK: - Segment
struct Segment: Codable {
    var departure: Arrival?
    var arrival: Arrival?
    var carrierCode: String?
    var number: String?
    var aircraft: Aircraft?
    var operating: Operating?
    var duration: String?
    var id: String?
    var numberOfStops: Int?
    var blacklistedInEU: Bool?
    var co2Emission: [Co2Emission]?

    enum CodingKeys: String, CodingKey {
        case departure = "departure"
        case arrival = "arrival"
        case carrierCode = "carrierCode"
        case number = "number"
        case aircraft = "aircraft"
        case operating = "operating"
        case duration = "duration"
        case id = "id"
        case numberOfStops = "numberOfStops"
        case blacklistedInEU = "blacklistedInEU"
        case co2Emission = "co2Emissions"
    }
}

// MARK: - Aircraft
struct Aircraft: Codable {
    var code: String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
    }
}

// MARK: - Arrival
struct Arrival: Codable {
    var iataCode: String?
    var at: String?
    var terminal: String?

    enum CodingKeys: String, CodingKey {
        case iataCode = "iataCode"
        case at = "at"
        case terminal = "terminal"
    }
}

// MARK: - Operating
struct Operating: Codable {
    var carrierCode: String?

    enum CodingKeys: String, CodingKey {
        case carrierCode = "carrierCode"
    }
}

// MARK: - AllDataPrice
struct AllDataPrice: Codable {
    var currency: String?
    var total: String?
    var base: String?
    var fees: [Fee]?
    var grandTotal: String?

    enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case total = "total"
        case base = "base"
        case fees = "fees"
        case grandTotal = "grandTotal"
    }
}

// MARK: - Fee
struct Fee: Codable {
    var amount: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case type = "type"
    }
}

// MARK: - PricingOptions
struct PricingOptions: Codable {
    var fareType: [String]?
    var includedCheckedBagsOnly: Bool?

    enum CodingKeys: String, CodingKey {
        case fareType = "fareType"
        case includedCheckedBagsOnly = "includedCheckedBagsOnly"
    }
}

// MARK: - TravelerPricing
struct TravelerPricing: Codable {
    var travelerId: String?
    var fareOption: String?
    var travelerType: String?
    var price: TravelerPricingPrice?
    var fareDetailsBySegment: [FareDetailsBySegment]?

    enum CodingKeys: String, CodingKey {
        case travelerId = "travelerId"
        case fareOption = "fareOption"
        case travelerType = "travelerType"
        case price = "price"
        case fareDetailsBySegment = "fareDetailsBySegment"
    }
}

// MARK: - FareDetailsBySegment
struct FareDetailsBySegment: Codable {
    var segmentId: String?
    var cabin: String?
    var fareBasis: String?
    var fareDetailsBySegmentClass: String?
    var includedCheckedBags: IncludedCheckedBags?
    var sliceDiceIndicator: String?

    enum CodingKeys: String, CodingKey {
        case segmentId = "segmentId"
        case cabin = "cabin"
        case fareBasis = "fareBasis"
        case fareDetailsBySegmentClass = "class"
        case includedCheckedBags = "includedCheckedBags"
        case sliceDiceIndicator = "sliceDiceIndicator"
    }
}

// MARK: - IncludedCheckedBags
struct IncludedCheckedBags: Codable {
    var quantity: Int?

    enum CodingKeys: String, CodingKey {
        case quantity = "quantity"
    }
}

// MARK: - TravelerPricingPrice
struct TravelerPricingPrice: Codable {
    var currency: String?
    var total: String?
    var base: String?

    enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case total = "total"
        case base = "base"
    }
}

// MARK: - FlightDict
struct FlightDict: Codable {
    var flightsList: [FlightsList]?
    var totalDuration: String?
    var numberOfStops: Int?

    enum CodingKeys: String, CodingKey {
        case flightsList = "flights_list"
        case totalDuration = "totalDuration"
        case numberOfStops = "numberOfStops"
    }
}

// MARK: - FlightsList
struct FlightsList: Codable {
    var segmentId: String?
    var departureDatetime: String?
    var arrivalDatetime: String?
    var departureIataCode: String?
    var departureAirportName: String?
    var departureLocation: Location?
    var arrivalIataCode: String?
    var arrivalAirportName: String?
    var arrivalLocation: Location?
    var duration: String?
    var carrierCode: String?
    var airlineName: String?
    var airlineNumber: String?
    var airline_logo: String?
    var aircraftCode: String?
    var aircrafName: String?
    var cabin: String?
    var flightsListClass: String?
    var fareBasis: String?
    var travelerPricingsSegmentId: String?

    enum CodingKeys: String, CodingKey {
        case segmentId = "segmentId"
        case departureDatetime = "Departure datetime"
        case arrivalDatetime = "Arrival datetime"
        case departureIataCode = "Departure iataCode"
        case departureAirportName = "Departure airportName"
        case departureLocation = "Departure location"
        case arrivalIataCode = "Arrival iataCode"
        case arrivalAirportName = "Arrival airportName"
        case arrivalLocation = "Arrival location"
        case duration = "duration"
        case carrierCode = "carrierCode"
        case airlineName = "airlineName"
        case airline_logo
        case airlineNumber = "airlineNumber"
        case aircraftCode = "aircraftCode"
        case aircrafName = "aircrafName"
        case cabin = "cabin"
        case flightsListClass = "class"
        case fareBasis = "fareBasis"
        case travelerPricingsSegmentId = "travelerPricings_segmentId"
    }
}

// MARK: - Location
struct Location: Codable {
    var cityCode: String?
    var countryCode: String?

    enum CodingKeys: String, CodingKey {
        case cityCode = "cityCode"
        case countryCode = "countryCode"
    }
}

// MARK: - ReturnFlightDict
struct ReturnFlightDict: Codable {
    var returnFlightsList: [ReturnFlightsList]?
    var totalDuration: String?
    var numberOfStops: Int?

    enum CodingKeys: String, CodingKey {
        case returnFlightsList = "return_flights_list"
        case totalDuration = "totalDuration"
        case numberOfStops = "numberOfStops"
    }
}

// MARK: - ReturnFlightsList
struct ReturnFlightsList: Codable {
    var segmentId: String?
    var departureDatetime: String?
    var arrivalDatetime: String?
    var departureIataCode: String?
    var departureAirportName: String?
    var departureLocation: Location?
    var arrivalIataCode: String?
    var arrivalLocation: Location?
    var arrivalAirportName: String?
    var duration: String?
    var carrierCode: String?
    var airlineName: String?
    var airlineNumber: String?
    var airline_logo: String?
    var aircraftCode: String?
    var aircrafName: String?
    var cabin: String?
    var returnFlightsListClass: String?
    var fareBasis: String?
    var travelerPricingsSegmentId: String?

    enum CodingKeys: String, CodingKey {
        case segmentId = "segmentId"
        case departureDatetime = "Departure datetime"
        case arrivalDatetime = "Arrival datetime"
        case departureIataCode = "Departure iataCode"
        case departureAirportName = "Departure airportName"
        case departureLocation = "Departure_location"
        case arrivalIataCode = "Arrival iataCode"
        case arrivalLocation = "Arrival_location"
        case arrivalAirportName = "Arrival airportName"
        case duration = "duration"
        case carrierCode = "carrierCode"
        case airlineName = "airlineName"
        case airlineNumber = "airlineNumber"
        case airline_logo
        case aircraftCode = "aircraftCode"
        case aircrafName = "aircrafName"
        case cabin = "cabin"
        case returnFlightsListClass = "class"
        case fareBasis = "fareBasis"
        case travelerPricingsSegmentId = "travelerPricings_segmentId"
    }
}
enum StringInt: Codable {
    case string(String)
    case int(Int)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
           return
        }
        if let x = try? container.decode(Int.self) {
            self = .int(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(StringInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MyValue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .int(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
    
    var value: String? {
        switch self {
        case .int(let num):
            return "\(num)"
        case .string(let num):
            return num
        case .double(let num):
            return "\(num)"
        }
    }
}
