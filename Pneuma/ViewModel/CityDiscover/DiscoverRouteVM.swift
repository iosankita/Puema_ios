//
//  DiscoverRouteVM.swift
//  Pneuma
//
//  Created by Chitra on 16/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class DiscoverRouteVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = DiscoverRouteDataSource()
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        self.tableDataSource.listArray = [DiscoverRouteModel(placeName: "Blue Rose Cafe", placeType: .restaurants, timings: "08:00-20:00 (30 min)", website: "www.restaurantname.com"), DiscoverRouteModel(placeName: "Hungry Fish", placeType: .cinemaTheater, timings: "08:00 - 22:00 (30 min)", website: "www.restaurantname.com"), DiscoverRouteModel(placeName: "Aurora", placeType: .shoppingCenters, timings: "08:00 - 22:00 (30 min)", website: "www.aurorashop.com")]
    }
}
