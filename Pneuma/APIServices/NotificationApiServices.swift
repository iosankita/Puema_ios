//
//  NotificationApiServices.swift
//  Pneuma
//
//  Created by MacBook Pro on 31/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

fileprivate enum NotificationApiServicesEndPoints: APIService {
    //Define cases according to API's
    case getAllNotifications
    case storeNotification(_ parameters: [String: Any])
    case deleteNotification(_ parameters: [String: Any])
    
    //Return path according to api case
    var path: String {
        switch self {
        case .getAllNotifications:
            return AppConstants.Urls.apiBaseUrl + "api/notifications"
        case .storeNotification:
            return AppConstants.Urls.apiBaseUrl + "api/notifications/store"
        case .deleteNotification:
            return AppConstants.Urls.apiBaseUrl + "api/notifications/delete/1"
            
    }
}
    
    //Return resource according to api case
    var resource: Resource {
        
        let headers: [String: Any] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
        ]
        
        switch self {
        case .getAllNotifications:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .storeNotification(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .deleteNotification(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        }
        
    }
    
}

struct NotificationApiServices {
    
    func getAllNotifications(completionBlock: @escaping ApiResponseCompletion) {
        NotificationApiServicesEndPoints.getAllNotifications.request(completionBlock: completionBlock)
    }
    func storeNotification(_ parameters: [String: Any],completionBlock: @escaping ApiResponseCompletion) {
        NotificationApiServicesEndPoints.storeNotification(parameters).urlRequest(completionBlock: completionBlock)
    }
    func deleteNotification(_ parameters: [String: Any],completionBlock: @escaping ApiResponseCompletion) {
        NotificationApiServicesEndPoints.deleteNotification(parameters).urlRequest(completionBlock: completionBlock)
    }
}
