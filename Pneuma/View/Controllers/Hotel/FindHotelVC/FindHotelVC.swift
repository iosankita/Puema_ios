//
//  FindHotelVC.swift
//  Pneuma
//
//  Created by Jatin on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class FindHotelVC: UIViewController, HotelDelegate, DateDelegate, HotelAdditionalOptionDelegate, AlertProtocol {

    // MARK: - IBOUTLETS
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var navigation: CustomNavigationView!
    
    // MARK: - VARIABLES
    var isFromDate1 : Bool = false
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.dateMonth.rawValue
        return formatter
    }()
    var departureDate : Date? = Date()
    var returnDepartureDate : Date? = Date()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.delegate = self
        destinationLabel.text = "Mohali"
        self.dateLabel.text = departureDate?.string(withFormat: "yyyy-MM-dd")
        self.dateLabel2.text = returnDepartureDate?.dayAfter.string(withFormat: "yyyy-MM-dd")
    }
    
    // MARK: - IBACTIONS
    @IBAction func destinationButtonAction(_ sender: UIButton) {
        self.gotoChooseLocation()
    }
    
    @IBAction func dateButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.loadChooseDateVC()
        vc.dateDelegate = self
        vc.isFromBookAFlightDate1 = true
        vc.selectedDate = self.departureDate
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func dateButtonAction2(_ sender: UIButton) {
        let vc = UIStoryboard.loadChooseDateVC()
        vc.dateDelegate = self
        vc.isFromBookAFlightDate2 = true
        vc.selectedDate = self.returnDepartureDate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func roomButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.loadHotelAdditionalOptionVC()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        if self.destinationLabel.text! == "Enter Destination"{
            self.showAlertWithText("Please Enter Destination")
            return
        }
        let vc = UIStoryboard.loadHotelSearchResultVC()
        vc.checkinDate = self.departureDate ?? Date()
        vc.checkoutDate = self.returnDepartureDate ?? Date()
        if let location = self.destinationLabel.text {
            vc.location = location
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func micChatButtonAction(_ sender: UIButton) {
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func gotoChooseLocation() {
        let vc = UIStoryboard.loadChooseAddressVC()
        let vm = ChooseAddressVM(locationType: .destination)
        vc.setupViewModel(vm)
        vc.isfrom = .hotel
        vc.delegateHotel = self
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func setHotel(cityName: String) {
        destinationLabel.text = cityName
    }

    func setDate(date: Date, from: DateFrom) {
        switch from {
        case .bookFirstDate:
            self.dateLabel.text = self.dateFormatter.string(from: date)
            self.departureDate = date
            self.dateLabel2.text = self.dateFormatter.string(from: date.dayAfter)
            self.returnDepartureDate = date.dayAfter
            break
        case .bookSecondDate:
            if let dDate = self.departureDate {
                if dDate > date {
                    self.dateLabel.text = self.dateFormatter.string(from: date.dayBefore)
                    self.departureDate = date.dayBefore
                }
            }
            self.dateLabel2.text = self.dateFormatter.string(from: date)
            self.returnDepartureDate = date
            break
        case .bookPassenger:
            break
        }
    }

    func setPeopleAndRoom(adults: Int, children: Int, rooms: Int) {
        var room = ""
        var adult = ""
        var childrens = ""
        if rooms == 1 {
            room = "\(rooms) Room, "
        }else {
            room = "\(rooms) Rooms, "
        }
        if adults == 1 || adults == 0 {
            adult = "\(adults) Adult, "
        }else {
            adult = "\(adults) Adults, "
        }
        if children == 1 || children == 0{
            childrens = "\(children) Children"
        }else {
            childrens = "\(children) Childrens"
        }
        roomLabel.text = room + adult + childrens
    }
}

// MARK: - NAVIGATION DELEGATE
extension FindHotelVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressLeft button: UIButton) {
        //
    }
}
