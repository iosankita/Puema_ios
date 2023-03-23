//
//  CurrencyApiServices.swift
//  Pneuma
//
//  Created by MacBook Pro on 31/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

fileprivate enum CurrencyApiServicesEndPoints: APIService {
    //Define cases according to API's
    case getAllCurrencies
    case storeCurrency(_ parameters: [String: Any])
    case deleteCurrency(_ parameters: [String: Any])
    
    //Return path according to api case
    var path: String {
        switch self {
        case .getAllCurrencies:
            return AppConstants.Urls.apiBaseUrl + "api/currencies"
        case .storeCurrency:
            return AppConstants.Urls.apiBaseUrl + "api/currencies/store"
        case .deleteCurrency:
            return AppConstants.Urls.apiBaseUrl + "api/currencies/delete/1"
            
    }
}
    
    //Return resource according to api case
    var resource: Resource {
        
        let headers: [String: Any] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
        ]
        
        switch self {
        case .getAllCurrencies:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .storeCurrency(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .deleteCurrency(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        }
        
    }
    
}

struct CurrencyApiServices {
    
    func getAllCurrencies(completionBlock: @escaping ApiResponseCompletion) {
        CurrencyApiServicesEndPoints.getAllCurrencies.request(completionBlock: completionBlock)
    }
    func storeCurrency(_ parameters: [String: Any],completionBlock: @escaping ApiResponseCompletion) {
        CurrencyApiServicesEndPoints.storeCurrency(parameters).urlRequest(completionBlock: completionBlock)
    }
    func deleteCurrency(_ parameters: [String: Any],completionBlock: @escaping ApiResponseCompletion) {
        CurrencyApiServicesEndPoints.deleteCurrency(parameters).urlRequest(completionBlock: completionBlock)
    }
}
