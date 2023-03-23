//
//  TimeRangeVC.swift
//  Pneuma
//
//  Created by Jatin on 18/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class TimeRangeVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var startTimeTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var minutesTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - VARIABLES
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startTimeTextField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.containerView.roundCorners([.topLeft, .topRight], radius: 16)
    }
    
    // MARK: - IBACTIONS
    @IBAction func saveButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    

}

// MARK: - TEXTFIELD DELEGATE
extension TimeRangeVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.startTimeTextField {
            DatePicker.shared.showDatePicker(with: textField, minimumDate: Date())
        }
        return true
    }
}
