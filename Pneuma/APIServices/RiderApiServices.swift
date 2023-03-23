//
//  RiderApiServices.swift
//  Pneuma
//
//  Created by MacBook Pro on 31/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

fileprivate enum RiderApiServicesEndPoints: APIService {
    //Define cases according to API's
    case report(_ parameters: [String: Any])
    case rate(_ parameters: [String: Any])
    
    //Return path according to api case
    var path: String {
        switch self {
        case .report:
            return AppConstants.Urls.apiBaseUrl + "api/rider/report"
            
        case .rate:
            return AppConstants.Urls.apiBaseUrl + "api/rider/rating"
            
            
            
    }
}
    
    //Return resource according to api case
    var resource: Resource {
        
        let headers: [String: Any] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
        ]
        
        switch self {
        case .report(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .rate(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        }
        
    }
    
}

struct RiderApiServices {
    
    func report(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        RiderApiServicesEndPoints.report(parameters).urlRequest(completionBlock: completionBlock)
    }
    func rate(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        RiderApiServicesEndPoints.rate(parameters).urlRequest(completionBlock: completionBlock)
    }
    
}

