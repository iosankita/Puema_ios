//
//  TravelBuddiesApiServices.swift
//  Pneuma
//
//  Created by MacBook Pro on 25/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

fileprivate enum TravelBuddiesApiServicesEndPoints: APIService {
    //Define cases according to API's
    case getAllBuddies
    case storeTravelBuddy(_ parameters: [String: Any])
    
    //Return path according to api case
    var path: String {
        switch self {
        case .getAllBuddies:
            return AppConstants.Urls.apiBaseUrl + "api/travel-buddies"
        case .storeTravelBuddy:
            return AppConstants.Urls.apiBaseUrl + "api/travel-buddy/store"
            
            
    }
}
    
    //Return resource according to api case
    var resource: Resource {
        
        let headers: [String: Any] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
        ]
        
        switch self {
        case .getAllBuddies:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .storeTravelBuddy(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        
            
        }
        
    }
    
}

struct TravelBuddiesApiServices {
    
    func getAllBuddies(completionBlock: @escaping ApiResponseCompletion) {
        TravelBuddiesApiServicesEndPoints.getAllBuddies.request(completionBlock: completionBlock)
    }
    func storeTravelBuddy(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        TravelBuddiesApiServicesEndPoints.storeTravelBuddy(parameters).urlRequest(completionBlock: completionBlock)
    }
    
}

