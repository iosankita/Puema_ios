//
//  CityDiscoverListVM.swift
//  Pneuma
//
//  Created by Chitra on 11/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class CityDiscoverListVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = DiscoverListDataSource()
    var selectionCallback: ((CityDiscoverListModel)->())?
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        self.tableDataSource.listArray = [CityDiscoverListModel(name: "Big Museum", address: "Trevi, 600m from center", rating: 4, images: ["dummyImage", "dummyImage", "dummyImage"], openingHours: "08:00-20:00"),
                                          CityDiscoverListModel(name: "Museum 1", address: "Trevi, 600m from center", rating: 2, images: ["dummyImage", "dummyImage"]),
                                          CityDiscoverListModel(name: "Dummy Museum", address: "Trevi, 600m from center", rating: 3, images: ["dummyImage"])]
    }
}

extension CityDiscoverListVM {
    func selectItem(at index: Int) {
        selectionCallback?(self.tableDataSource.listArray[index])
    }
}
