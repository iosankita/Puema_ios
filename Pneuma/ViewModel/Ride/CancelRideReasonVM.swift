//
//  CancelRideReasonVM.swift
//  Pneuma
//
//  Created by Chitra on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class CancelRideReasonVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = CancelRideReasonTableDataSource()
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        self.tableDataSource.listArray = [CancelRideReasonModel(title: "Search did not find a driver"), CancelRideReasonModel(title: "My Plans have changed"), CancelRideReasonModel(title: "Other Reason")]
    }
}

// MARK: - TABLE FUNCTIONS
extension CancelRideReasonVM {
    func selectItem(at indexPath: IndexPath) {
        for i in 0..<self.tableDataSource.listArray.count {
            self.tableDataSource.listArray[i].isSelected = (i == indexPath.row)
        }
    }
}
