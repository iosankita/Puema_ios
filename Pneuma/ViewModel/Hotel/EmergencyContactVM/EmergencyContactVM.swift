//
//  EmergencyContactVM.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class EmergencyContactVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = EmergencyContactTableDataSource()
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        let model1 = EmergencyContactCategoryModel(name: "Police", contacts: [
            EmergencyContactDataModel(title: "Via Adeodato Ressi, 82", subtitle: "Rome, italy", image: UIImage(named: "locationIconGray")),
            EmergencyContactDataModel(title: "1212", image: UIImage(named: "phoneIconGray"))
        ])
        let model2 = EmergencyContactCategoryModel(name: "Hospital", contacts: [
            EmergencyContactDataModel(title: "Radeodato Ressi,18", subtitle: "Rome, italy", image: UIImage(named: "locationIconGray")),
            EmergencyContactDataModel(title: "1212", image: UIImage(named: "phoneIconGray"))
        ])
        self.tableDataSource.listArray = [model1, model2]
    }
}

