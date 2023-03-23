//
//  CurrencyModel.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class CurrencyDataSourceModel: NSObject {
    var listArray = [CurrencyModel]()
}

class CurrencyModel {
    var title: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}
