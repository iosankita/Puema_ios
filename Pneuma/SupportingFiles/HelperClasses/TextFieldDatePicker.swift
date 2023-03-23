//
//  TextFieldDatePicker.swift
//  Pneuma
//
//  Created by Chitra on 17/02/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDatePicker: NSObject {
    static var shared = TextFieldDatePicker()
    var datePicker = UIDatePicker()
    var toolbar = UIToolbar()
    var selectedTextField: UITextField?
    var mode: UIDatePicker.Mode = .date {
        didSet {
            self.datePicker.datePickerMode = mode
        }
    }
    var didChangeDateCompletion: ((UIDatePicker) -> ())?
    var didTapDoneAction: ((UIDatePicker) -> ())?
    var selectedDateFormat: DateFormat = .standard
    
    override private init() {
        super.init()
    }
    
    func showDatePicker(with textField: UITextField, on view: UIView, minimumDate: Date? = nil, maximumDate: Date? = nil, mode: UIDatePicker.Mode = .date) {
        self.doneAction()
        self.toolbar = toolbarPiker(view: view)
        self.datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: view.frame.height-200, width: view.frame.size.width, height: 200))
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
            self.datePicker.frame = CGRect(x: 0, y: view.frame.height-200, width: view.frame.size.width, height: 200)
        } else {
            // Fallback on earlier versions
        }
        self.datePicker.datePickerMode = mode
        self.datePicker.backgroundColor = .white
        self.datePicker.addTarget(self, action: #selector(didChangeDate), for: .valueChanged)
        if let minDate = minimumDate {
            self.datePicker.minimumDate = minDate
        }
        
        if let maxDate = maximumDate {
            self.datePicker.maximumDate = maxDate
        }
        textField.inputView = self.datePicker
        if let text = textField.text, text != "" {
            if let date = Date.dateFromString(text, format: self.selectedDateFormat) {
                self.datePicker.setDate(date, animated: false)
            }else if let date = Date.dateFromString(text, format: self.selectedDateFormat) {
                textField.text = date.getString(format: self.selectedDateFormat)
                self.datePicker.setDate(date, animated: false)
            }
        }else {
            self.datePicker.setDate(maximumDate ?? Date(), animated: false)
            textField.text = (maximumDate ?? Date()).getString(format: self.selectedDateFormat)//format must be same as didChangeDate method's format.
        }
        self.selectedTextField = textField
        view.addSubview(self.datePicker)
        view.addSubview(self.toolbar)
    }


    func showDatePicker(with textField: UITextField, on view: UIView, minimumDate: Date? = nil, maximumDate: Date? = nil, mode: UIDatePicker.Mode = .date,format:DateFormat = .standard) {
        selectedDateFormat = format
        self.doneAction()
        self.toolbar = toolbarPiker(view: view)
        self.datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: view.frame.height-200, width: view.frame.size.width, height: 200))
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
            self.datePicker.frame = CGRect(x: 0, y: view.frame.height-200, width: view.frame.size.width, height: 200)
        } else {
            // Fallback on earlier versions
        }
        self.datePicker.datePickerMode = mode
        self.datePicker.backgroundColor = .white
        self.datePicker.addTarget(self, action: #selector(didChangeDateFormat), for: .valueChanged)
        if let minDate = minimumDate {
            self.datePicker.minimumDate = minDate
        }

        if let maxDate = maximumDate {
            self.datePicker.maximumDate = maxDate
        }
        textField.inputView = self.datePicker
        if let text = textField.text, text != "" {
            if let date = Date.dateFromString(text, format: format) {
                self.datePicker.setDate(date, animated: false)
            }else if let date = Date.dateFromString(text, format: format) {
                textField.text = date.getString(format: format)
                self.datePicker.setDate(date, animated: false)
            }
        }else {
            self.datePicker.setDate(maximumDate ?? Date(), animated: false)
            textField.text = (maximumDate ?? Date()).getString(format: format)//format must be same as didChangeDate method's format.
        }
        self.selectedTextField = textField
        view.addSubview(self.datePicker)
        view.addSubview(self.toolbar)
    }

    @objc func didChangeDate(_ picker: UIDatePicker) {
        selectedTextField?.text = picker.date.getString(format: self.selectedDateFormat)
        self.didChangeDateCompletion?(picker)
    }

    @objc func didChangeDateFormat(_ picker: UIDatePicker) {

        selectedTextField?.text = picker.date.getString(format: self.selectedDateFormat)
        self.didChangeDateCompletion?(picker)
    }
    
    @objc func doneAction(){
        self.datePicker.removeFromSuperview()
        self.toolbar.removeFromSuperview()
        self.didTapDoneAction?(self.datePicker)
    }
    
    public func didChangeDateCompletion(completion: ((UIDatePicker) -> ())?) {
        didChangeDateCompletion = completion
    }
    
    func toolbarPiker(view: UIView) -> UIToolbar {
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: view.frame.size.height-240, width: view.frame.size.width, height: 40))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
}
