//
//  AppCache.swift
//  Pneuma
//
//  Created by Jatin on 22/09/20.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class AppCache: NSObject {
    
    static let shared = AppCache()
    
    // MARK: - CLASS LIFE CYCLE
    private override init() {
        super.init()
    }
    
    // MARK: - VARIABLES
    var currentUser: UserModel? {
        set {
            if let value = newValue, let data = JSONEncoder().convertToData(value) {
                UserDefaults.standard.setValue(data, forKey: AppConstants.UserDefault.currentUser)
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.standard.setValue(nil, forKey: AppConstants.UserDefault.currentUser)
                UserDefaults.standard.synchronize()
            }
        }
        get {
            if let data = UserDefaults.standard.data(forKey: AppConstants.UserDefault.currentUser) {
                return JSONDecoder().convertDataToModel(data)
            }
            return nil
        }
    }
    
    var isWalkthroughShown: Bool {
        get {
            return UserDefaults.standard.bool(forKey: AppConstants.UserDefault.walkthroughShown)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppConstants.UserDefault.walkthroughShown)
            UserDefaults.standard.synchronize()
        }
    }
    
    var isInitialQuestionAnswered: Bool {
        get {
            return UserDefaults.standard.bool(forKey: AppConstants.UserDefault.initialQuestionsAnswered)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppConstants.UserDefault.initialQuestionsAnswered)
            UserDefaults.standard.synchronize()
        }
    }
    
    var authToken: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: AppConstants.UserDefault.authToken)
            UserDefaults.standard.synchronize()
        }
        get {
            UserDefaults.standard.string(forKey: AppConstants.UserDefault.authToken)
        }
    }
    
    var selectedBookingOptions = SelectedBookingTypes()
        
    func removeAllUserDefaults() {
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
        }
    }
}
