//
//  FlightBookingCompletedVM.swift
//  Pneuma
//
//  Created by Jatin on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class FlightBookingCompletedVM: NSObject {
    // MARK: - VARIABLES
    var bookingModel: SearchFlightsDataModel?
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getData()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    func getData() {
        self.bookingModel = SearchFlightsDataModel(title: "", imageName: "searchFlightLogo-1")
    }
    
}
