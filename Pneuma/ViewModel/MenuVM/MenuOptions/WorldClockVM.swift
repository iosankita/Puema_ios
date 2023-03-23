//
//  WorldClockVM.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class WorldClockVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = WorldClockDataSource()
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.tableDataSource.deleteCallBack = { (index) in
            self.didDelete(at: index)
        }
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        self.tableDataSource.listArray = [WorldClockModel(placeName: "London", timeDiff: "+2h", currentTime: "12:17", date: "Mon, 17 Aug"),
                                          WorldClockModel(placeName: "Moscow", timeDiff: "Like Current Time", currentTime: "14:47", date: "Mon, 17 Aug")]
    }
}

// MARK: - TABLE FUNCTIONS
extension WorldClockVM {
    func didDelete(at index: Int) {
        print(index)
    }
}
