//
//  WorldClockModel.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class WorldClockDataSourceModel: NSObject {
    var listArray = [WorldClockModel]()
}

class WorldClockModel {
    var placeName: String
    var timeDiff: String
    var currentTime: String
    var date: String
    
    init(placeName: String, timeDiff: String, currentTime: String, date: String) {
        self.placeName = placeName
        self.timeDiff = timeDiff
        self.currentTime = currentTime
        self.date = date
    }
        
}
