//
//  RideInfoVM.swift
//  Pneuma
//
//  Created by Jatin on 16/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation


class RideInfoVM: NSObject {
    // MARK: - VARIABLES
    var infoModel: RideModel
    
    // MARK: - INITIALIZER
    init(model: RideModel) {
        self.infoModel = model
        super.init()
    }
}
