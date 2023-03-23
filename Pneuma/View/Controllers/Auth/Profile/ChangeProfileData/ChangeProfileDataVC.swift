//
//  ChangeProfileDataVC.swift
//  Pneuma
//
//  Created by Chitra on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

enum ChangeMode {
    case email
    case password
    case name
    case phone
    case passport
}

class ChangeProfileDataVC: UIViewController {
    
    //MARK:- IBOUTLETS
    @IBOutlet weak var changeNameView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var changeEmailView: UIView!
    @IBOutlet weak var emailCurrentPasswordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var currentPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var changePhoneView: UIView!
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    @IBOutlet weak var changePassportView: UIView!
    @IBOutlet weak var nationalityTF: UITextField!
    @IBOutlet weak var issueDateTF: UITextField!
    @IBOutlet weak var expiryDateTF: UITextField!
    @IBOutlet weak var countryCodeTF: UITextField!
    @IBOutlet weak var passportNumberTF: UITextField!
    @IBOutlet weak var citizenshipNumberTF: UITextField!
    
    
    //MARK:- VARIABLES
    var changeMode: ChangeMode = .name
    var viewModel = MyProfileVM()
    var parentVC: MyProfileVC? = nil
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModeUI()
    }
    
    //MARK:- IBACTIONS
    @IBAction func saveAction(_ sender: Any) {
        switch changeMode {
        case .name:
            self.viewModel.editNameRequestModel.name = self.nameTF.text
            if let message = self.viewModel.nameValidation() {
                self.showAlertWithText(message)
            }else {
                self.changeName()
            }
        case .email:
            self.viewModel.editEmailRequestModel.email = self.emailTF.text
            self.viewModel.editEmailRequestModel.password = self.emailCurrentPasswordTF.text
            if let message = self.viewModel.emailValidation() {
                self.showAlertWithText(message)
            }else {
                self.changeEmail()
            }
        case .password:
            self.viewModel.editPasswordRequestModel.old_password = self.currentPasswordTF.text
            self.viewModel.editPasswordRequestModel.new_password = self.newPasswordTF.text
            self.viewModel.editPasswordRequestModel.confirm_password = self.confirmPasswordTF.text
            if let message = self.viewModel.passwordValidation() {
                self.showAlertWithText(message)
            }else {
                self.changePassword()
            }
        case .passport:
            self.viewModel.editPassportRequestModel.nationality = self.nationalityTF.text
            self.viewModel.editPassportRequestModel.passport_issue_date = self.issueDateTF.text
            self.viewModel.editPassportRequestModel.passport_expiry_date = self.expiryDateTF.text
            self.viewModel.editPassportRequestModel.passport_country_code = self.countryCodeTF.text
            self.viewModel.editPassportRequestModel.passport_number = self.passportNumberTF.text
            self.viewModel.editPassportRequestModel.passport_citizenship_number = self.citizenshipNumberTF.text
            if let message = self.viewModel.passportValidation() {
                self.showAlertWithText(message)
            }else {
                self.changePassport()
            }
        case .phone:
            self.viewModel.editPhoneRequestModel.phone = self.phoneNumberTF.text
            if let message = self.viewModel.phoneValidation() {
                self.showAlertWithText(message)
            }else {
                self.changePhone()
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- PRIVATE FUNCTIONS
    private func setupModeUI() {
        changeNameView.isHidden = true
        changeEmailView.isHidden = true
        changePasswordView.isHidden = true
        changePassportView.isHidden = true
        changePhoneView.isHidden = true
        
        switch changeMode {
        case .name:
            changeNameView.isHidden = false
        case .email:
            changeEmailView.isHidden = false
        case .password:
            changePasswordView.isHidden = false
        case .passport:
            changePassportView.isHidden = false
        case .phone:
            changePhoneView.isHidden = false
        }
    }
}
extension ChangeProfileDataVC : AlertProtocol{
    func changeName() {
        
        CustomLoader.shared.show()
        self.viewModel.editName { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                //Handle UI or navigation
                self.showAlertWithText(response.message) { [weak self] (action) in
                    self?.viewModel.getUser { _ in
                        self?.parentVC?.updateData()
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            case .failure(let error):
                self.showAlertWithText(error.message)
            }
        }
    }
    func changeEmail() {
        CustomLoader.shared.show()
        self.viewModel.editEmail { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                //Handle UI or navigation
                self.showAlertWithText(response.message) { [weak self] (action) in
                    self?.viewModel.getUser { _ in
                        self?.parentVC?.updateData()
                        self?.dismiss(animated: true, completion: nil)
                    }
                    
                }
            case .failure(let error):
                self.showAlertWithText(error.message)
            }
        }
    }
    func changePassword() {
        CustomLoader.shared.show()
        self.viewModel.editPassword { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                //Handle UI or navigation
                self.showAlertWithText(response.message) { [weak self] (action) in
                    self?.viewModel.getUser { _ in
                        self?.parentVC?.updateData()
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            case .failure(let error):
                self.showAlertWithText(error.message)
            }
        }
    }
    func changePassport() {
        CustomLoader.shared.show()
        self.viewModel.editPassport { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                //Handle UI or navigation
                self.showAlertWithText(response.message) { [weak self] (action) in
                    self?.viewModel.getUser { _ in
                        self?.parentVC?.updateData()
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            case .failure(let error):
                self.showAlertWithText(error.message)
            }
        }
    }
    func changePhone() {
        CustomLoader.shared.show()
        self.viewModel.editPhone { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                //Handle UI or navigation
                self.showAlertWithText(response.message) { [weak self] (action) in
                    self?.viewModel.getUser { _ in
                        self?.parentVC?.updateData()
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            case .failure(let error):
                self.showAlertWithText(error.message)
            }
        }
    }
}
