//
//  OutboundDetailDataModel.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class OutboundDetailTableDataSourceModel: NSObject {
    var listArray = [OutboundDetailDataModel]()
    var listAirItineraryMode = [AirItineraryModel]()
    var airlineModel  = [AirlineInfoModel]()
    var arrSearchCityData : [SearchCityData] = []
}

struct OutboundDetailDataModel {
    var title: String
    var hideBottomOval: Bool = true
}
struct OutboundModel {
    var data: OutboundDetaiModel?
    
}
struct OutboundDetaiModel {
    var SequenceNumber: Int?
    var AirItinerary:AirItineraryDetailModel?
    var AirItineraryPricingInfo : AirItineraryPricingInfoModel?
//    var TicketingInfo : TicketingInfo?
//    var TPA_Extensions : TPA_Extensions?
    var DataSource : String?
    
}

struct AirItineraryDetailModel {
    var SequenceNumber: Int?
  
    
}
struct AirItineraryDataModel: Codable  {
    var data : [AirlineInfoModel]?
    enum CodingKeys: String, CodingKey {
        case data
           }
}
struct AirlineInfoModel: Codable {
    var AirlineCode : String?
    var AirlineName : String?
    var AlternativeBusinessName : String?
    enum CodingKeys: String, CodingKey {
        case AirlineCode
        case AirlineName
        case AlternativeBusinessName
    }
}
