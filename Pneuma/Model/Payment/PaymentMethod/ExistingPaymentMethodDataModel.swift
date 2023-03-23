//
//  ExistingPaymentMethodDataModel.swift
//  Pneuma
//
//  Created by Jatin on 17/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class ExistingPaymentMethodTableDataSourceModel: NSObject {
    var listArray = [ExistingPaymentMethodDataModel]()
}

struct ExistingPaymentMethodDataModel {
    var title: String
    var separator: Bool = true
    var selected: Bool = false
}

