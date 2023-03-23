//
//  CityDiscoverVM.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class CityDiscoverVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = CityDiscoverDataSource()
    var selectionCallback: ((CityDiscoverType)->())?
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        self.tableDataSource.listArray = [
            CityDiscoverModel(image: CityDiscoverType.restaurants.image, title: CityDiscoverType.restaurants.rawValue, type: .restaurants),
            CityDiscoverModel(image: CityDiscoverType.cinemaTheater.image, title: CityDiscoverType.cinemaTheater.rawValue, type: .cinemaTheater),
            CityDiscoverModel(image: CityDiscoverType.museums.image, title: CityDiscoverType.museums.rawValue, type: .museums),
            CityDiscoverModel(image: CityDiscoverType.shoppingCenters.image, title: CityDiscoverType.shoppingCenters.rawValue, type: .shoppingCenters),
            CityDiscoverModel(image: CityDiscoverType.sights.image, title: CityDiscoverType.sights.rawValue, type: .sights),
            CityDiscoverModel(image: CityDiscoverType.funPlace.image, title: CityDiscoverType.funPlace.rawValue, type: .funPlace)]
    }
}

extension CityDiscoverVM {
    func selectItem(at index: Int) {
        let selectedType = self.tableDataSource.listArray[index].type
        self.selectionCallback?(selectedType)
    }
}
