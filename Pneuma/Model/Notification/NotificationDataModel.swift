//
//  NotificationDataModel.swift
//  Pneuma
//
//  Created by MacBook Pro on 31/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation


class NotificationModel : Codable {
    var id: Int?
    var name: String?
    var created_at: String?
    var updated_at: String?
    
}

struct GetNotificationsResponseModel: Codable {
    var message: String?
    var data: [NotificationModel]?
}


struct StoreNotificationRequestModel: Codable {
    var name: String?
}

struct StoreNotificationResponseModel: Codable {
    //var status: String?
    var message: String?
    var data: NotificationModel?
    
}
struct DeleteNotificationRequestModel: Codable {
    var name: String?
}

struct DeleteNotificationResponseModel: Codable {
    //var status: String?
    var message: String?
    
}

struct StoreUserNotificationRequestModel: Codable {
    var notification_id: String?
}

struct StoreUserNotificationResponseModel: Codable {
    //var status: String?
    var message: String?
    
}

struct StoreNotificationViaRequestModel: Codable {
    var notify_via: String?
}

struct StoreNotificationViaResponseModel: Codable {
    //var status: String?
    var message: String?
    
}
