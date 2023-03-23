//
//  DatePicker.swift
//  LogyTalks
//
//  Created by Jatin on 07/12/20.
//  Copyright © 2020 Jatin. All rights reserved.
//

import UIKit

class DatePicker: NSObject {
    static var shared = DatePicker()
    var datePicker: UIDatePicker!
    var selectedTextField: UITextField?
    var mode: UIDatePicker.Mode = .date {
        didSet {
            self.datePicker?.datePickerMode = mode
        }
    }
    var didChangeDateCompletion: ((UIDatePicker) -> ())?
    var selectedDateFormat: DateFormat = .appDate
    
    override private init() {
        super.init()
    }
    
    func showDatePicker(with textField: UITextField, minimumDate: Date? = nil, maximumDate: Date? = nil, mode: UIDatePicker.Mode = .date) {
        self.selectedDateFormat = mode == .time ? .timeWith12Hour: .appDate
        let screenWidth = UIScreen.main.bounds.width
        self.datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        self.datePicker.datePickerMode = mode
        /*if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        }*/
        self.datePicker.addTarget(self, action: #selector(didChangeDate), for: .valueChanged)
        if let minDate = minimumDate {
            self.datePicker.minimumDate = minDate
        }
        
        if let maxDate = maximumDate {
            self.datePicker.maximumDate = maxDate
        }
        textField.inputView = self.datePicker
        if let text = textField.text, text != "" {
            if let date = Date.dateFromString(text, format: .appDate) {
                self.datePicker.setDate(date, animated: false)
            }/*else if let date = Date.dateFromString(text, format: .dateTime) {
                textField.text = date.getString(newFormat: self.selectedDateFormat)
                self.datePicker.setDate(date, animated: false)
            }*/
        }else {
            self.datePicker.setDate(Date(), animated: false)
            textField.text = Date().getString(newFormat: self.selectedDateFormat)//format must be same as didChangeDate method's format.
        }
        self.selectedTextField = textField
    }
    
    @objc func didChangeDate(_ picker: UIDatePicker) {
        selectedTextField?.text = picker.date.getString(newFormat: self.selectedDateFormat)
        self.didChangeDateCompletion?(picker)
    }
}
