//
//  PayVM.swift
//  Pneuma
//
//  Created by Jatin on 15/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class PayVM: NSObject {
    
    // MARK: - VARIABLES
    let flightTableDataSource = OutboundDetailTableDataSource()
    let hotelAmenitiesCollectionDataSource = HotelInfoCollectionDataSource()
    let hotelBenifitsCollectionDataSource = HotelInfoCollectionDataSource()
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getList()
        self.getHotelAmenities()
        self.getHotelBenifits()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        let model1 = OutboundDetailDataModel(title: "")
        let model2 = OutboundDetailDataModel(title: "", hideBottomOval: false)
        self.flightTableDataSource.listArray = [model1, model2]
    }
    
    private func getHotelAmenities() {
        let model1 = HotelInfoDataModel(title: "Swimming Pool")
        let model2 = HotelInfoDataModel(title: "Safety Deposit Box")
        let model3 = HotelInfoDataModel(title: "Restaurant")
        let model4 = HotelInfoDataModel(title: "Lift")
        let model5 = HotelInfoDataModel(title: "Free WiFi")
        let model6 = HotelInfoDataModel(title: "Bar")
        let model7 = HotelInfoDataModel(title: "Free Parking")
        self.hotelAmenitiesCollectionDataSource.listArray = [model1, model2, model3, model4, model5, model6, model7]
    }
    
    private func getHotelBenifits() {
        let model1 = HotelInfoDataModel(title: "Good Breakfast Included")
        let model2 = HotelInfoDataModel(title: "Free Cancellation before 23:59 on 24 June 2020")
        let model3 = HotelInfoDataModel(title: "No Prepayment Needed-Pay at the Property")
        self.hotelBenifitsCollectionDataSource.listArray = [model1, model2, model3]
    }
}

