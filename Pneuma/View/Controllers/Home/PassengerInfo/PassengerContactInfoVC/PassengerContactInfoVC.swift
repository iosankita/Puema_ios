//
//  PassengerContactInfoVC.swift
//  Pneuma
//
//  Created by Jatin on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import FlagPhoneNumber

protocol PassengerContactInfoVCDelegate: class {
    func vc(_ vc: PassengerContactInfoVC, didPressNext button: UIButton, arrData: [PassangerDict])
}


class PassengerContactInfoVC: UIViewController, AlertProtocol {
    // MARK: - IBOUTLETS
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneNumberTextField: FPNTextField!
    @IBOutlet weak var acceptTermsButton: UIButton!
    
    // MARK: - VARIABLES
    weak var delegate: PassengerContactInfoVCDelegate?
    var objFlightSearchResponseData : FlightSearchResponseData?
    var numberOfBookSeat : Int? = 0
    var arrPassengerList: [PassangerDict]!
    var countryCallingCode : String = ""
    var isPhoneValid : Bool = false
    var numberOfAdults : Int? = 0
    var numberOfChildren : Int? = 0
    var numberOfInfants : Int? = 0
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.textColor = UIColor.gray
        //txtSignUpPhone?.parentViewController = self
        phoneNumberTextField.delegate = self
        phoneNumberTextField.font = UIFont(name: "Poppins-Medium", size: 15.0)!
        phoneNumberTextField.setFlag(countryCode: .US)
        //phoneNumberTextField.setFlag(key: .US)

    }
    
    // MARK: - IBACTIONS
    @IBAction func nextButtonAction(_ sender: UIButton) {
        arrPassengerList[0].email = emailTextField.text ?? ""
        //arrPassengerList[0].mobileNumber = phoneNumberTextField.text ?? ""
        let data = arrPassengerList[0]
        if data.email.isEmpty || data.mobileNumber.isEmpty || data.email.checkIsValidEmail() == false || acceptTermsButton.isSelected == false || isPhoneValid == false{
            if data.email.isEmpty || emailTextField.text?.isEmptyWithTrimmedSpace ?? true {
                self.showAlertWithText(LocalizedStringEnum.enterEmailAddress.localized)
            }else if data.email.checkIsValidEmail() == false {
                self.showAlertWithText(LocalizedStringEnum.enterValidEmailAddress.localized)
            }else if data.mobileNumber.isEmpty {
                self.showAlertWithText("passenger mobile number should not be empty")
            }else if isPhoneValid == false{
                self.showAlertWithText("please enter valid phone number")
            }else if acceptTermsButton.isSelected == false {
                self.showAlertWithText("please accept terms & condition")
            }
            return
        }
        self.delegate?.vc(self, didPressNext: sender, arrData: arrPassengerList)
    }
    
    @IBAction func accetTermsButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    // MARK: - PRIVATE FUNCTIONS
    
}

extension PassengerContactInfoVC : FPNTextFieldDelegate {
    func fpnDisplayCountryList() {
        //
    }

    // MARK: - FPNTextfield Delegate Methods
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        print(isValid, textField.getRawPhoneNumber())
        if isValid {
            isPhoneValid = isValid
            arrPassengerList[0].mobileNumber = textField.getRawPhoneNumber() ?? ""
            phoneNumberTextField.text = textField.getRawPhoneNumber()
        }else {
            isPhoneValid = isValid
        }
    }

    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
        arrPassengerList[0].countryCode = dialCode
    }

}
