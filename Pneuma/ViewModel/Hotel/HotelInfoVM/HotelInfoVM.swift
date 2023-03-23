//
//  HotelInfoVM.swift
//  Pneuma
//
//  Created by Jatin on 15/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class HotelInfoVM: NSObject {
    // MARK: - VARIABLES
    let collectionDataSource = HotelInfoCollectionDataSource()
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        let model1 = HotelInfoDataModel(title: "Swimming Pool")
        let model2 = HotelInfoDataModel(title: "Safety Deposit Box")
        let model3 = HotelInfoDataModel(title: "Restaurant")
        let model4 = HotelInfoDataModel(title: "Lift")
        let model5 = HotelInfoDataModel(title: "Free WiFi")
        let model6 = HotelInfoDataModel(title: "Bar")
        let model7 = HotelInfoDataModel(title: "Free Parking")
        self.collectionDataSource.listArray = [model1, model2, model3, model4, model5, model6, model7]
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
