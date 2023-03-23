//
//  DiscoverRouteModel.swift
//  Pneuma
//
//  Created by Chitra on 16/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class DiscoverRouteDataSourceModel: NSObject {
    var listArray = [DiscoverRouteModel]()
}


class DiscoverRouteModel {
    var placeName: String
    var placeType: CityDiscoverType
    var timings: String
    var website: String
    
    init(placeName: String, placeType: CityDiscoverType, timings: String, website: String) {
        self.placeName = placeName
        self.placeType = placeType
        self.timings = timings
        self.website = website        
    }
}
