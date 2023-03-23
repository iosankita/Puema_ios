//
//  AuthApiServices.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import Foundation

fileprivate enum AuthApiServicesEndPoints: APIService {
    //Define cases according to API's
    case login(_ parameters: [String: Any])
    case socialLogin(_ parameters: [String: Any])
    case register(_ parameters: [String: Any])
    case forgotPassword(_ parameters: [String: Any])
    case resetPassword(_ parameters: [String: Any])
    case logout
    case getUser
    
    //Return path according to api case
    var path: String {
        switch self {
        case .login:
            return AppConstants.Urls.apiBaseUrl + "api/login"
            
        case .socialLogin:
            return AppConstants.Urls.apiBaseUrl + "api/social/login"
            
        case .register:
            return AppConstants.Urls.apiBaseUrl + "api/register"
            
        case .forgotPassword:
            return AppConstants.Urls.apiBaseUrl + "api/forgot-password"
        
        case .resetPassword:
            return AppConstants.Urls.apiBaseUrl + "api/resetPassword"
        
        case .logout:
            return AppConstants.Urls.apiBaseUrl + "api/logout"
            
        case .getUser:
            return AppConstants.Urls.apiBaseUrl + "api/user"
            
    }
}
    
    //Return resource according to api case
    var resource: Resource {
        
        
        
        
        switch self {
        case .login(let params):
            let headers: [String: Any] = [
                "Content-Type": "application/json"
            ]
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        
        case .socialLogin(let params):
            let headers: [String: Any] = [
                "Content-Type": "application/json"
            ]
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .register(let params):
            let headers: [String: Any] = [
                "Content-Type": "application/json"
            ]
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .forgotPassword(let params):
            let headers: [String: Any] = [
                "Content-Type": "application/json"
            ]
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .resetPassword(let params):
            let headers: [String: Any] = [
                "Content-Type": "application/json"
            ]
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .logout:
            let headersWithToken: [String: Any] = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
            ]
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
            
        case .getUser:
            let headersWithToken: [String: Any] = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
            ]
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
            
        }
        
        
    }
    
}

struct AuthApiServices {
    
    func login(_ parameters: [String: String], completionBlock: @escaping ApiResponseCompletion) {
        AuthApiServicesEndPoints.login(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func socialLogin(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthApiServicesEndPoints.socialLogin(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func register(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthApiServicesEndPoints.register(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func forgotPassword(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthApiServicesEndPoints.forgotPassword(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func resetPassword(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthApiServicesEndPoints.resetPassword(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func logout(completionBlock: @escaping ApiResponseCompletion) {
        AuthApiServicesEndPoints.logout.urlRequest(completionBlock: completionBlock)
    }
    
    func getUser(completionBlock: @escaping ApiResponseCompletion) {
        AuthApiServicesEndPoints.getUser.urlRequest(completionBlock: completionBlock)
    }
    
}
