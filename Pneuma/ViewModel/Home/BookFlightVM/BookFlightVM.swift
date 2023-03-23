//
//  BookFlightVM.swift
//  Pneuma
//
//  Created by Jatin on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class BookFlightVM: NSObject {
    
    // MARK: - VARIABLES
    var screenType: BookFlightScreenType
    
    // MARK: - INITIALIZER
    init(screenType: BookFlightScreenType) {
        self.screenType = screenType
        super.init()
    }
}
