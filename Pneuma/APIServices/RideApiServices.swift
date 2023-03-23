//
//  RideApiServices.swift
//  Pneuma
//
//  Created by MacBook Pro on 25/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

fileprivate enum RideApiServicesEndPoints: APIService {
    //Define cases according to API's
    case book(_ parameters: [String: Any])
    case getAllRideBookings
    case getCurrentRideBooking
    case getPastRideBookings
    case getUpcomingRideBooking
    
    //Return path according to api case
    var path: String {
        switch self {
        case .book:
            return AppConstants.Urls.apiBaseUrl + "api/ride/book"
            
        case .getAllRideBookings:
            return AppConstants.Urls.apiBaseUrl + "api/bookings/rides"
            
        case .getCurrentRideBooking:
            return AppConstants.Urls.apiBaseUrl + "api/ride/ongoing"
            
        case .getPastRideBookings:
            return AppConstants.Urls.apiBaseUrl + "api/bookings/past/ride"
        
        case .getUpcomingRideBooking:
            return AppConstants.Urls.apiBaseUrl + "api/bookings/upcoming/ride"
            
            
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
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .getAllRideBookings:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .getCurrentRideBooking:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .getPastRideBookings:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .getUpcomingRideBooking:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        }
        
    }
    
}

struct RideApiServices {
    
    func book(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        RideApiServicesEndPoints.book(parameters).urlRequest(completionBlock: completionBlock)
    }
    func getAllRideBookings(completionBlock: @escaping ApiResponseCompletion) {
        RideApiServicesEndPoints.getAllRideBookings.request(completionBlock: completionBlock)
    }
    func getCurrentRideBooking(completionBlock: @escaping ApiResponseCompletion) {
        RideApiServicesEndPoints.getCurrentRideBooking.request(completionBlock: completionBlock)
    }
    func getPastRideBookings(completionBlock: @escaping ApiResponseCompletion) {
        RideApiServicesEndPoints.getPastRideBookings.request(completionBlock: completionBlock)
    }
    
    func getUpcomingRideBooking(completionBlock: @escaping ApiResponseCompletion) {
        RideApiServicesEndPoints.getUpcomingRideBooking.request(completionBlock: completionBlock)
    }
    
}

