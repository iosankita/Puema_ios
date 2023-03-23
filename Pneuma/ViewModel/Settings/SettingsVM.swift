//
//  SettingsVM.swift
//  Pneuma
//
//  Created by Chitra on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class SettingsVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = SettingsDataSource()
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        self.tableDataSource.listArray = [.general: [SettingsModel(title: "App Language", infoData: "English", subType: .appLanguage),
                                                     SettingsModel(title: "Preferred Currency", infoData: "USD", subType: .preferredCurrency),
                                                     SettingsModel(title: "Payment", infoData: "", subType: .payment)],
                                          .notify: [SettingsModel(title: "About order cancelling"),
                                                    SettingsModel(title: "Drive on a Rate"),
                                                    SettingsModel(title: "Drive at the place")],
                                          .notifyVia: [SettingsModel(title: "Email"),
                                                        SettingsModel(title: "Phone"),
                                                        SettingsModel(title: "Push Notifications")]]
        
    }
}

// MARK: - TABLE FUNCTIONS
extension SettingsVM {
    func selectItem(at indexPath: IndexPath) {

    }
}
