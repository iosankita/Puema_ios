//
//  PaymentApiServices.swift
//  Pneuma
//
//  Created by MacBook Pro on 26/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
fileprivate enum PaymentApiServicesEndPoints: APIService {
    //Define cases according to API's
    case getAllPaymentMethods
    case getUserPaymentMethods
    
    //Return path according to api case
    var path: String {
        switch self {
        case .getAllPaymentMethods:
            return AppConstants.Urls.apiBaseUrl + "api/payment-methods"
        case .getUserPaymentMethods:
            return AppConstants.Urls.apiBaseUrl + "api/auth/payment-methods"
            
            
    }
}
    
    //Return resource according to api case
    var resource: Resource {
        
        let headers: [String: Any] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
        ]
        
        switch self {
        case .getAllPaymentMethods:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .getUserPaymentMethods:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        
            
        }
        
    }
    
}

struct PaymentApiServices {
    
    func getAllPaymentMethods(completionBlock: @escaping ApiResponseCompletion) {
        PaymentApiServicesEndPoints.getAllPaymentMethods.request(completionBlock: completionBlock)
    }
    
    func getUserPaymentMethods(completionBlock: @escaping ApiResponseCompletion) {
        PaymentApiServicesEndPoints.getUserPaymentMethods.request(completionBlock: completionBlock)
    }
    
}
