//
//  SignupVC.swift
//  Pneuma
//
//  Created by Chitra on 25/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class SignupVC: UIViewController, NavigationProtocol {

    //MARK:- IBOUTLETS
    @IBOutlet weak var nameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTF: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTF: SkyFloatingLabelTextField!
    @IBOutlet weak var termsTextView: UITextView!
    @IBOutlet weak var formShadowView: IQPreviousNextView!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var nameValidButton: UIButton!
    
    //MARK:- VARIABLES
    var signupModel = SignupVM()
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customiseUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK:- PRIVATE FUNCTION
    private func moveToInitialQuestionVC(){
        let vc = UIStoryboard.loadSplashVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setDataInViewModel() {
        self.signupModel.requestModel.name = self.nameTF.text
        self.signupModel.requestModel.email = self.emailTF.text
        self.signupModel.requestModel.password = self.passwordTF.text
        self.signupModel.requestModel.password_confirmation = self.confirmPasswordTF.text
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    //MARK:- IBACTIONS
    @IBAction func termsAction(_ sender: Any) {
        self.termsButton.isSelected = !(self.termsButton.isSelected)
    }
    
    @IBAction func showPasswordAction(_ sender: UIButton) {
        sender.isSelected = !(sender.isSelected)
        if sender.tag == 0 {
            passwordTF.isSecureTextEntry = !(sender.isSelected)
        } else if sender.tag == 1 {
            confirmPasswordTF.isSecureTextEntry = !(sender.isSelected)
        }
    }
    
    @IBAction func signupAction(_ sender: Any) {
        self.setDataInViewModel()
        if let message = self.signupModel.validation() {
               self.showAlertWithText(message)
        }else{
            self.signup()
        }
        //self.moveToInitialQuestionVC()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    
    @IBAction func googleAction(_ sender: Any) {
    }
    
    @IBAction func facebookAction(_ sender: Any) {
    }
    
    @IBAction func nameEditingChange(_ sender: UITextField) {
        let name = sender.text ?? ""
        nameValidButton.isSelected = name.isValidFullName()
    }
    
    
    //MARK:- PRIVATE FUNCTIONS
    private func customiseUI() {
        setClickableText()
        formShadowView.addShadow(ofColor: .lightGray, radius: 10.0, offset: .zero, opacity: 0.5)
    }
    
    private func setClickableText() {
        let attributedString = NSMutableAttributedString(string: "I Agree with the Terms & Conditions & Privacy Policy", attributes: [
            .font: AppFont.medium.fontWithSize(14.0),
            .foregroundColor: AppColor.darkText.getColor(),
            .kern: 0.0
        ])
        let termsUrl = URL(string: AppConstants.Urls.termsUrl)!
        attributedString.setAttributes([.link: termsUrl, .font: AppFont.medium.fontWithSize(14.0)], range: NSMakeRange(17, 18))
        let policyUrl = URL(string: AppConstants.Urls.privacyUrl)!
        attributedString.setAttributes([.link: policyUrl, .font: AppFont.medium.fontWithSize(14.0)], range: NSMakeRange(38, 14))
        
        self.termsTextView.linkTextAttributes = [.foregroundColor: AppColor.lightPink.getColor(),
                                                 .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        termsTextView.attributedText = attributedString
        termsTextView.isUserInteractionEnabled = true
        termsTextView.isEditable = false
        termsTextView.isSelectable = true
        termsTextView.dataDetectorTypes = .link

    }
}


//MARK:- API Methods
extension SignupVC: AlertProtocol {
    fileprivate func signup() {
        CustomLoader.shared.show()
        self.signupModel.signup { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(_):
                //Handle UI or navigation
                self.showAlertWithText(self.signupModel.responseModel?.message ?? "", buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
                    self.moveToInitialQuestionVC()
                }
                return
            case .failure(let error):
                self.showAlertWithText(error.message)
            }
        }
    }
}
