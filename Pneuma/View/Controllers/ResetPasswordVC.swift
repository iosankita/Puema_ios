//
//  ResetPasswordVC.swift
//  Pneuma
//
//  Created by iTechnolabs on 19/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController ,AlertProtocol,NavigationProtocol{

    //MARK:- IBOutlet
    @IBOutlet weak var otpPasswordTextfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    @IBOutlet weak var confirmNewPasswordTextfield: UITextField!
    
    // MARK: - VARIABLES
    var viewModel: ResetPasswordVM!
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    // MARK: - INTERNAL FUNCTIONS
//    func setupViewModel(_ viewModel: ResetPasswordVM) {
//        self.viewModel = viewModel
//    }
          
    // MARK: - PRIVATE FUNCTIONS
    ///Setting user input data to view model
    private func setDataInViewModel() {
        self.viewModel.requestModel.user_id = self.viewModel.userID
        self.viewModel.requestModel.reset_password_otp = self.otpPasswordTextfield.text
        self.viewModel.requestModel.password = self.PasswordTextfield.text
        self.viewModel.requestModel.confirm_password = self.confirmNewPasswordTextfield.text
    }
          
    private func navigateToLoginVC() {
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc.isKind(of: LoginVC.self) {
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }
    
    //MARK:- IBAction
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        /*self.setDataInViewModel()
        if let message = self.viewModel.validation() {
            self.showAlertWithText(message)
        }else {
            self.resetPassword()
        }*/
    }
    
}

// MARK: - API METHODS
extension ResetPasswordVC {
    func resetPassword() {
        CustomLoader.shared.show()
        self.viewModel.resetPassword { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
                
            case .success(let response):
                //Handle UI or navigation
                self.showAlertWithText(response.message) { [weak self] (action) in
                    self?.navigateToLoginVC()
                }
            case .failure(let error):
                self.showAlertWithText(error.message)
            }
        }
    }
}

// MARK: - TEXTFIELD DELEGATES
extension ResetPasswordVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.PasswordTextfield || textField == self.confirmNewPasswordTextfield {
            return textField.regex(range, string, maxLength: 8)
        }else if textField == self.otpPasswordTextfield{
            return textField.regex(range, string, maxLength: 4)
        }
        
        return true
    }
}
