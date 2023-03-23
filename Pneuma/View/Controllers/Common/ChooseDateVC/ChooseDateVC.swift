//
//  ChooseDateVC.swift
//  Pneuma
//
//  Created by Jatin on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import FSCalendar

protocol DateDelegate {
    func setDate(date:Date, from:DateFrom)
}

class ChooseDateVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var selectedDateButton: UIButton!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var calendarContainerView: UIView!
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var selectedDateContainerView: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var timeContainerView: UIView!
    
    // MARK: - VARIABLES
    var dateDelegate: DateDelegate?
    var isFromBookAFlightDate1 : Bool? = false
    var isFromBookAFlightDate2 : Bool? = false
    var isFromPassengerBooking : Bool? = false
    var selectedDate : Date? = nil
    var index : Int = 0
    var curentdate = Date()
    var endDate = Date()
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.dateMonth.rawValue
        return formatter
    }()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedDateButton.setTitle(self.dateFormatter.string(from: selectedDate ?? Date()), for: .normal)
        self.customizeUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setCornerRadius()
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func setupView(isTransparent: Bool, hideSelectedDateView: Bool = false, hideNavigationView: Bool = false, disableDismissButton: Bool = true, hideTime: Bool = true) {
        if isTransparent {
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        }
        self.selectedDateContainerView.isHidden = hideSelectedDateView
        self.navigationView.isHidden = hideNavigationView
        self.dismissButton.isUserInteractionEnabled = !disableDismissButton
        self.timeContainerView.isHidden = hideTime
    }
    
    // MARK: - IBACTIONS
    @IBAction func applyButtonAction(_ sender: UIButton) {
        if isFromBookAFlightDate1 == true {
            dateDelegate?.setDate(date: selectedDate ?? Date(), from: .bookFirstDate)
        }else if isFromBookAFlightDate2 == true {
            dateDelegate?.setDate(date: selectedDate ?? Date(), from: .bookSecondDate)
        }else if isFromPassengerBooking == true {
            dateDelegate?.setDate(date: selectedDate ?? Date(), from: .bookPassenger)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func leftArrowButtonAction(_ sender: UIButton) {
        self.calendarView.showPreviousMonth()
    }
    
    @IBAction func rightArrowButtonAction(_ sender: UIButton) {
        self.calendarView.showNextMonth()
    }
    
    @IBAction func dismissButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - PRIVATE FUNCTIONS
    private func setCornerRadius() {
        self.calendarContainerView.roundCorners([.topLeft, .topRight], radius: 16)
    }
    
    private func customizeUI() {
        self.calendarView.dataSource = self
        self.calendarView.delegate = self
        self.calendarView.setupCalendar()
    }
}

extension ChooseDateVC : FSCalendarDataSource, FSCalendarDelegate {

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        self.selectedDateButton.setTitle(self.dateFormatter.string(from: date), for: .normal)
        self.selectedDate = date
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
      
            if  isFromBookAFlightDate2 ==  true {
                if date <= curentdate || date.compare(Date()) == .orderedAscending {
                    return .lightGray
                } else {
                    return .black
                }
            }else if  isFromBookAFlightDate1 ==  true {
                if date >= endDate  || date < Date() || date.compare(Date()) == .orderedAscending {
                    return .lightGray
                } else {
                    return .black
                }
            }else  if date.compare(Date()) == .orderedAscending {
                return .lightGray
            } else {
                return .black
            }
        
    }
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
        self.selectedDateButton.setTitle(self.dateFormatter.string(from: calendar.currentPage), for: .normal)
        self.selectedDate = calendar.selectedDate
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if  isFromBookAFlightDate2 ==  true {
            if date <= curentdate || date.compare(Date()) == .orderedAscending {
                return false
            } else {
                return true
            }
        }else if  isFromBookAFlightDate1 ==  true {
            if date >= endDate  || date < Date() || date.compare(Date()) == .orderedAscending {
                return false
            } else {
                return true
            }
        }else  if date.compare(Date()) == .orderedAscending {
            return false
        } else {
            return true
        }
    }

}

