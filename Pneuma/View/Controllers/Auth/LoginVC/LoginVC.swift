//
//  LoginVC.swift
//  Pneuma
//
//  Created by Chitra on 26/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class LoginVC: UIViewController, NavigationProtocol {

    //MARK:- IBOUTLETS
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTF: SkyFloatingLabelTextField!
    @IBOutlet weak var formShadowView: IQPreviousNextView!
    
    //MARK:- VARIABLES
    var loginInModel = LoginVM()
    var initialQVM = InitialQuestionsVM()
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //MARK:- PRIVATE FUNCTION
    private func setDataInViewModel() {
        self.loginInModel.requestModel.email = self.emailTF.text
        self.loginInModel.requestModel.password = self.passwordTF.text
           
    }
    
    private func moveToInitialQuestionVC(){
        let vc = UIStoryboard.loadSplashVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- IBACTIONS
    @IBAction func loginAction(_ sender: Any) {
        self.setDataInViewModel()
         if let message = self.loginInModel.validation() {
           self.showAlertWithText(message)
         }else{
             self.loginIn()
         }
    }
    
    @IBAction func showPasswordAction(_ sender: UIButton) {
        sender.isSelected = !(sender.isSelected)
        passwordTF.isSecureTextEntry = !(sender.isSelected)
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        let vc = UIStoryboard.loadForgotPasswordVC()
        self.navigationController?.pushViewController(vc)
    }
    
    @IBAction func signupAction(_ sender: Any) {
        let vc = UIStoryboard.loadSignupVC()
        self.navigationController?.pushViewController(vc)
    }
    
    @IBAction func termsPrivacyAction(_ sender: UIButton) {
        if sender.tag == 0, let url = URL(string: AppConstants.Urls.termsUrl), UIApplication.shared.canOpenURL(url) { //Terms
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else if sender.tag == 1, let url = URL(string: AppConstants.Urls.privacyUrl), UIApplication.shared.canOpenURL(url) { //Privacy poilcy
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func googleAction(_ sender: Any) {
    }
    
    @IBAction func facebookAction(_ sender: Any) {
    }
    
    //MARK:- PRIVATE FUNCTIONS
    private func customizeUI() {
        formShadowView.addShadow(ofColor: .lightGray, radius: 10.0, offset: .zero, opacity: 0.5)
    }
}

//MARK:- API METHODS
extension LoginVC: AlertProtocol {
     fileprivate func loginIn() {
           CustomLoader.shared.show()
           self.loginInModel.login { [weak self] (result) in
               CustomLoader.shared.hide()
               guard let `self` = self else {
                   return
               }
               switch result {
               case .success(_):
                   //Handle UI or navigation
                   self.showAlertWithText(self.loginInModel.responseModel?.message ?? "", buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
                      self.moveToInitialQuestionVC()
                   }
                   return
               case .failure(let error):
                   self.showAlertWithText(error.message)
               }
           }
       }
    
    fileprivate func getAllAnswers() {
          CustomLoader.shared.show()
        self.initialQVM.getAnswerList { [weak self] (result) in
              CustomLoader.shared.hide()
              guard let `self` = self else {
                  return
              }
              switch result {
              case .success(_):
                  //Handle UI or navigation
                  //if(self.initialQVM.answerResponseModel)
                  return
              case .failure(let error):
                  self.moveToInitialQuestionVC()
              }
          }
      }
}
