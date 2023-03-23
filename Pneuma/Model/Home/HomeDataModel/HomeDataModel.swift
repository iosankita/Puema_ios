//
//  HomeDataModel.swift
//  Pneuma
//
//  Created by Jatin on 26/02/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
import UIKit

class HomeTableDataSourceModel: NSObject {
    var listArray = [HomeDataModel]()
}

struct SelectedBookingTypes {
    var types = [BookingTypeEnum]()
    
    mutating func nextController() -> UIViewController? {
        guard let bookingType = self.types.first else {
            return nil
        }
        
        switch bookingType {
        
        case .bookFlight:
            let vm = BookFlightVM(screenType: .bookFlight)
            let vc = UIStoryboard.loadBookFlightVC()
            vc.setupViewModel(vm)
            return vc
        case .findHotel:
            return UIStoryboard.loadFindHotelVC()
        case .getRide:
            return UIStoryboard.loadGetRideVC()
        case .askAnnie:
            return UIStoryboard.loadAskAnnieVC()
        }
    }
    
    mutating func completeCurrentStep() {
        if self.types.count > 0 {
            self.types.removeFirst()
        }
    }
}

enum BookingTypeEnum {
    case bookFlight
    case findHotel
    case getRide
    case askAnnie
}

struct HomeDataModel {
    
    var title: String
    var type: BookingTypeEnum
    var isSelected: Bool = false
    var image: UIImage? {
        let imageName = self.isSelected ? "\(self.title)-Selected" : self.title
        return UIImage(named: imageName)
    }
    var checkboxImage: UIImage? {
        let imageName = self.isSelected ? "filledCheckbox" : "emptyCheckbox"
        return UIImage(named: imageName)
    }
    var borderColor: UIColor {
        return self.isSelected ? .purply : .lightGray2
    }
    var backgroundColor: UIColor {
        return self.isSelected ? .paleMauve : .white
    }
    
}
