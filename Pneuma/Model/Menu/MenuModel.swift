//
//  MenuModel.swift
//  Pneuma
//
//  Created by Chitra on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
enum Storyboard<T : UIViewController>: String {
    case Main
    case Home
    
    func instantiateVC() -> T {
        let sb = UIStoryboard(name: self.rawValue, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
        return vc
    }
}

class MenuDataSourceModel: NSObject {
    var listArray = [[MenuModel]]()
}

class MenuModel {
    
    var type: MenuItem
    var isActive: Bool
    var title: String {
        return self.type.displayString
    }
    
    init(type: MenuItem, isActive: Bool = false) {
        self.isActive = isActive
        self.type = type
    }
}

enum MenuItem {
    case home
    case bookAFlight
    case findAHotel
    case getARide
    case myProfile
    case settings
    case myFlightTickets
    case myHotelBookings
    case myRides
    case myTrips
    case emergencyServices
    case worldClock
    
    var displayString: String {
        switch self {
        case .home:
            return "Home"
        case .bookAFlight:
            return "Book A Flight"
        case .findAHotel:
            return "Find A Hotel"
        case .getARide:
            return "Get A Ride"
        case .myProfile:
            return "My Profile"
        case .settings:
            return "Settings"
        case .myFlightTickets:
            return "My Flight Tickets"
        case .myHotelBookings:
            return "My Hotel Bookings"
        case .myRides:
            return "My Rides"
        case .myTrips:
            return "My Trips"
        case .emergencyServices:
            return "Emergency Services"
        case .worldClock:
            return "World Clock"
        default:
            return ""
        }
    }
    
}
