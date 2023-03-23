//
//  ProfileApiServices.swift
//  Pneuma
//
//  Created by MacBook Pro on 24/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

fileprivate enum ProfileApiServicesEndPoints: APIService {
    //Define cases according to API's
    case updateName(_ parameters: [String: Any])
    case updatePhone(_ parameters: [String: Any])
    case updateEmail(_ parameters: [String: Any])
    case updatePassword(_ parameters: [String: Any])
    case updatePassportDetails(_ parameters: [String: Any])
    
    //Return path according to api case
    var path: String {
        switch self {
        case .updateName:
            return AppConstants.Urls.apiBaseUrl + "api/profile/update/name"
            
        case .updatePhone:
            return AppConstants.Urls.apiBaseUrl + "api/profile/update/phone"
            
        case .updateEmail:
            return AppConstants.Urls.apiBaseUrl + "api/profile/update/email"
            
        case .updatePassword:
          return AppConstants.Urls.apiBaseUrl + "api/profile/update/password"
            
        case .updatePassportDetails:
          return AppConstants.Urls.apiBaseUrl + "api/profile/update/passport"
            
    }
}
    
    //Return resource according to api case
    var resource: Resource {
//        let headers: [String: Any] = [
//            "Content-Type": "application/json"
//        ]
        
        let headers: [String: Any] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
        ]
        
        switch self {
        case .updateName(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        
        case .updatePhone(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .updateEmail(let params):
           return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .updatePassword(let params):
           return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .updatePassportDetails(let params):
           return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        }
        
    }
    
}

struct ProfileApiServices {
    
    func updateName(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        ProfileApiServicesEndPoints.updateName(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func updatePhone(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        ProfileApiServicesEndPoints.updatePhone(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func updateEmail(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        ProfileApiServicesEndPoints.updateEmail(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func updatePassword(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        ProfileApiServicesEndPoints.updatePassword(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func updatePassportDetails(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        ProfileApiServicesEndPoints.updatePassportDetails(parameters).urlRequest(completionBlock: completionBlock)
    }
    
}

