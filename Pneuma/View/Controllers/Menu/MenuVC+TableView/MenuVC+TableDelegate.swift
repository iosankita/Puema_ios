//
//  MenuVC+TableDelegate.swift
//  Pneuma
//
//  Created by Chitra on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension MenuVC: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectItem(at: indexPath)
        //FIXME:- Open Selected Screen
        
    
        self.dismiss(animated: true) { [weak self] in
            self?.gotoRespectiveScreen(indexPath: indexPath)
        }
    
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            return MenuSectionHeaderView.loadFromNib(named: "MenuSectionHeaderView")
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 10
        }
        return 0
    }
}

// MARK: - NAVIGATION FUNCTIONS
extension MenuVC {
    func gotoRespectiveScreen(indexPath: IndexPath) {
        let menuType = self.viewModel.tableDataSource.listArray[indexPath.section][indexPath.row].type
        
        switch menuType {
        
        case .bookAFlight:
            self.gotoBookFlightVC()
        case .findAHotel:
            self.gotoFindHotelVC()
        case .getARide:
            self.gotoGetRideVC()
        case .myProfile:
            self.gotoMyProfileVC()
        case .settings:
            self.gotoSettingsVC()
            
        case .myFlightTickets:
            self.gotoFlightTicketsVC()
        case .myHotelBookings:
            self.gotoHotelBookingsVC()
        case .myRides:
            self.gotoMyRidesVC()
        case .myTrips:
            self.gotoMyTripsVC()
            
        case .emergencyServices:
            self.gotoEmergencyServicesVC()
        case .worldClock:
            self.gotoWorldClockVC()
        default:
            return
        }
    }
    
    private func pushToVC(_ vc: UIViewController) {
        let navigationVC = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        navigationVC?.pushViewController(vc)
    }
    
    func gotoMyTravelBuddies() {
        self.dismiss(animated: true) { [weak self] in
            let vc = UIStoryboard.loadTravelBuddyVC()
            self?.pushToVC(vc)
        }
        
    }
    
    private func gotoHotelBookingsVC() {
        let vc = UIStoryboard.loadHotelBookingsVC()
        self.pushToVC(vc)
    }
    
    private func gotoMyRidesVC() {
        let vc = UIStoryboard.loadMyRidesVC()
        self.pushToVC(vc)
    }
    
    private func gotoMyTripsVC() {
        let vc = UIStoryboard.loadMyTripsVC()
        self.pushToVC(vc)
    }
    
    private func gotoBookFlightVC() {
        let vm = BookFlightVM(screenType: .bookFlight)
        let vc = UIStoryboard.loadBookFlightVC()
        vc.setupViewModel(vm)
        self.pushToVC(vc)
    }
    
    private func gotoFindHotelVC() {
        let vc = UIStoryboard.loadFindHotelVC()
        self.pushToVC(vc)
    }
    
    private func gotoGetRideVC() {
        let vc = UIStoryboard.loadGetRideVC()
        self.pushToVC(vc)
    }
    
    private func gotoMyProfileVC() {
        let vc = UIStoryboard.loadMyProfileVC()
        self.pushToVC(vc)
    }
    
    private func gotoSettingsVC() {
        let vc = UIStoryboard.loadSettingsVC()
        self.pushToVC(vc)
    }
    
    private func gotoEmergencyServicesVC() {
        let vc = UIStoryboard.loadEmergencyContactVC()
        self.pushToVC(vc)
    }
    
    private func gotoWorldClockVC() {
        let vc = UIStoryboard.loadWorldClockVC()
        self.pushToVC(vc)
    }
    
    private func gotoFlightTicketsVC() {
        let vc = UIStoryboard.loadFlightTicketsVC()
        self.pushToVC(vc)
    }
}
