//
//  ForgotPasswordVC.swift
//  Pneuma
//
//  Created by Chitra on 26/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ForgotPasswordVC: UIViewController,AlertProtocol {

    //MARK:- IBOUTLETS
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var formShadowView: IQPreviousNextView!
    
    //MARK:- VARIABLES
    var viewModel = ForgotPasswordVM()
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customiseUI()
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func setupViewModel(_ viewModel: ForgotPasswordVM) {
        self.viewModel = viewModel
    }
    
    //MARK:- PRIVATE FUNCTIONS
      ///Setting user input data to view model
    private func setDataInViewModel() {
        self.viewModel.requestModel?.email = self.emailTF.text
    }
    
    private func navigateToChangePasswordVC() {
//        guard let id = self.viewModel.responseModel?.data?.userID else {
//                  return
//        }
        let vc = UIStoryboard.loadResetPasswordVC()
//        let vm = ResetPasswordVM(userID: "\(id)")
//        vc.setupViewModel(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- IBACTIONS
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    @IBAction func submitAction(_ sender: Any) {
        self.setDataInViewModel()
        if let message = self.viewModel.validation() {
            self.showAlertWithText(message)
        }else {
            self.forgotPassword()
        }
        
    }
    
    //MARK:- PRIVATE FUNCTIONS
    private func customiseUI() {
        formShadowView.addShadow(ofColor: .lightGray, radius: 10.0, offset: .zero, opacity: 0.5)
    }
}
// MARK: - API METHODS
extension ForgotPasswordVC {
    func forgotPassword() {
        CustomLoader.shared.show()
        self.viewModel.forgotPassword { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                //Handle UI or navigation
                self.showAlertWithText(response.message) { [weak self] (action) in
                    self?.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                self.showAlertWithText(error.message)
            }
        }
    }
}
