//
//  UserPreferencesApiServices.swift
//  Pneuma
//
//  Created by MacBook Pro on 26/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

fileprivate enum UserPreferencesApiServicesEndPoints: APIService {
    //Define cases according to API's
    case storePaymentMethod(_ parameters: [String: Any])
    case updatePaymentMethod(_ parameters: [String: Any])
    case userNotification(_ parameters: [String: Any])
    case notificationVia(_ parameters: [String: Any])
    case currencyPreference(_ parameters: [String: Any])
    
    //Return path according to api case
    var path: String {
        switch self {
        case .storePaymentMethod:
            return AppConstants.Urls.apiBaseUrl + "api/user/payment-method/store"
        case .updatePaymentMethod:
            return AppConstants.Urls.apiBaseUrl + "api/user/payment-method/update"
        case .userNotification:
            return AppConstants.Urls.apiBaseUrl + "api/user/notification/store"
        case .notificationVia:
            return AppConstants.Urls.apiBaseUrl + "api/user/notification_via"
        case .currencyPreference:
            return AppConstants.Urls.apiBaseUrl + "api/user/currency_preference"
            
    }
}
    
    //Return resource according to api case
    var resource: Resource {
        
        let headers: [String: Any] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
        ]
        
        switch self {
        case .storePaymentMethod(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .updatePaymentMethod(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .userNotification(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .notificationVia(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .currencyPreference(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        
            
        }
        
    }
    
}

struct UserPreferencesApiServices {
    
    func storePaymentMethod(_ parameters: [String: Any],completionBlock: @escaping ApiResponseCompletion) {
        UserPreferencesApiServicesEndPoints.storePaymentMethod(parameters).urlRequest(completionBlock: completionBlock)
    }
    func updatePaymentMethod(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        UserPreferencesApiServicesEndPoints.updatePaymentMethod(parameters).urlRequest(completionBlock: completionBlock)
    }
    func userNotification(_ parameters: [String: Any],completionBlock: @escaping ApiResponseCompletion) {
        UserPreferencesApiServicesEndPoints.userNotification(parameters).urlRequest(completionBlock: completionBlock)
    }
    func notificationVia(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        UserPreferencesApiServicesEndPoints.notificationVia(parameters).urlRequest(completionBlock: completionBlock)
    }
    func currencyPreference(_ parameters: [String: Any],completionBlock: @escaping ApiResponseCompletion) {
        UserPreferencesApiServicesEndPoints.currencyPreference(parameters).urlRequest(completionBlock: completionBlock)
    }
    
}
