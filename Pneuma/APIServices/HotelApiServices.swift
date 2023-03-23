//
//  HotelApiServices.swift
//  Pneuma
//
//  Created by MacBook Pro on 25/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

fileprivate enum HotelApiServicesEndPoints: APIService {
    //Define cases according to API's
    case book(_ parameters: [String: Any])
    case getAllHotelBookings
    case getCurrentHotelBooking
    case getPastHotelBookings
    case getUpcomingHotelBooking
    case getHotelSearch(_ parameters: [String: Any])
    
    //Return path according to api case
    var path: String {
        switch self {
        case .book:
            return AppConstants.Urls.apiBaseUrl + "api/hotel/book"
            
        case .getAllHotelBookings:
            return AppConstants.Urls.apiBaseUrl + "api/bookings/hotels"
        
        case .getCurrentHotelBooking:
            return AppConstants.Urls.apiBaseUrl + "api/hotel/booking/current"
            
        case .getPastHotelBookings:
            return AppConstants.Urls.apiBaseUrl + "api/bookings/past/hotel"
        
        case .getUpcomingHotelBooking:
            return AppConstants.Urls.apiBaseUrl + "api/bookings/upcoming/hotel"

        case .getHotelSearch:
            return AppConstants.Urls.externalHotelSearchUrl
    }
}
    
    //Return resource according to api case
    var resource: Resource {
        
        let headers: [String: Any] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
        ]
        
        switch self {
        case .book(let params):
            let headers: [String: Any] = [
                "Accept": "application/json",
                "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
            ]
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .getAllHotelBookings:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .getCurrentHotelBooking:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .getPastHotelBookings:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .getUpcomingHotelBooking:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)

        case .getHotelSearch(let params):
            return Resource(method: .get, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        }
        
    }
    
}

struct HotelApiServices {
    
    func book(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        HotelApiServicesEndPoints.book(parameters).urlRequest(completionBlock: completionBlock)
    }
    func getAllHotelBookings(completionBlock: @escaping ApiResponseCompletion) {
        HotelApiServicesEndPoints.getAllHotelBookings.request(completionBlock: completionBlock)
    }
    func getCurrentHotelBooking(completionBlock: @escaping ApiResponseCompletion) {
        HotelApiServicesEndPoints.getCurrentHotelBooking.request(completionBlock: completionBlock)
    }
    func getPastHotelBookings(completionBlock: @escaping ApiResponseCompletion) {
        HotelApiServicesEndPoints.getPastHotelBookings.request(completionBlock: completionBlock)
    }
    
    func getUpcomingHotelBooking(completionBlock: @escaping ApiResponseCompletion) {
        HotelApiServicesEndPoints.getUpcomingHotelBooking.request(completionBlock: completionBlock)
    }

    func getHotelSearch(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        HotelApiServicesEndPoints.getHotelSearch(parameters).request(completionBlock: completionBlock)
    }
    
}

