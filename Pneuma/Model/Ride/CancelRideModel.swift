//
//  CancelRideModel.swift
//  Pneuma
//
//  Created by Chitra on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class CancelRideReasonDataSourceModel: NSObject {
    var listArray = [CancelRideReasonModel]()
}

class CancelRideReasonModel {
    var title: String
    var isSelected: Bool
    
    init(title: String, selected: Bool = false) {
        self.title = title
        self.isSelected = selected
    }
}
