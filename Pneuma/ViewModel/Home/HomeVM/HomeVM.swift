//
//  HomeVM.swift
//  Pneuma
//
//  Created by Jatin on 26/02/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class HomeVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = HomeTableDataSource()
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        let model1 = HomeDataModel(title: "Book A Flight", type: .bookFlight)
        let model2 = HomeDataModel(title: "Find a Hotel", type: .findHotel)
        let model3 = HomeDataModel(title: "Get A Ride", type: .getRide)
        let model4 = HomeDataModel(title: "Ask Annie", type: .askAnnie)
        self.tableDataSource.listArray = [model1, model2, model3, model4]
    }
}

// MARK: - TABLE FUNCTIONS
extension HomeVM {
    func selectItem(at indexPath: IndexPath) {
        
        self.tableDataSource.listArray[indexPath.row].isSelected = !self.tableDataSource.listArray[indexPath.row].isSelected
        let model = self.tableDataSource.listArray[indexPath.row]
        if model.isSelected {
            AppCache.shared.selectedBookingOptions.types.append(model.type)
        }else {
            if let index = AppCache.shared.selectedBookingOptions.types.firstIndex(where: {$0 == model.type}) {
                AppCache.shared.selectedBookingOptions.types.remove(at: index)
            }
        }
    }
}
