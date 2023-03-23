//
//  AddTravelBuddyVC.swift
//  Pneuma
//
//  Created by Chitra on 08/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import Alamofire

protocol TravelBuddyDelegate {
    func reloadTable()
}

class AddTravelBuddyVC: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet weak var customNav: CustomNavigationView!
    @IBOutlet weak var firstNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var middleNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var dobTF: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK:- VARIABLES
    var viewModel = AddTravelBuddyVM()
    var delegate: TravelBuddyDelegate?
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        dobTF.delegate = self
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        middleNameTF.delegate = self
        customNav.delegate = self
        emailTF.delegate = self
    }
    
    //MARK:- IBOUTLETS
    @IBAction func saveAction(_ sender: Any) {
        //self.viewModel.requestModel.first_name = self.firstNameTF.text
        //self.viewModel.requestModel.middle_name = self.middleNameTF.text
        //self.viewModel.requestModel.last_name = self.lastNameTF.text
        //self.viewModel.requestModel.dob = self.dobTF.text
        self.viewModel.requestModel.email = self.emailTF.text
        //self.viewModel.requestModel.user_id = AppCache.shared.currentUser?.id ?? 1
        self.viewModel.requestModel.name = "\(self.firstNameTF.text!) \(self.middleNameTF.text!) \(self.lastNameTF.text!)"

        if self.firstNameTF.text!.isEmpty {
            self.showAlertWithText("Please fill first name")
            return
        }else if self.middleNameTF.text!.isEmpty {
            self.showAlertWithText("Please fill middle name")
            return
        }else if self.lastNameTF.text!.isEmpty {
            self.showAlertWithText("Please fill last name")
            return
        }
        if let message = self.viewModel.validation() {
           self.showAlertWithText(message)
        }else{
           self.addTravelBuddyMul()
        }
    }
   
}

//MARK:- UITEXTFIELD DELEGATE
extension AddTravelBuddyVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        TextFieldDatePicker.shared.doneAction()
        if textField == dobTF {
            DispatchQueue.main.async {
                self.view.endEditing(false)
                self.scrollToBottom()
            }
            TextFieldDatePicker.shared.showDatePicker(with: textField, on: self.view, maximumDate: Date(), mode: .date, format: .fullDate) //showDatePicker(with: textField, on: self.view, maximumDate: Date(), mode: .date)
            TextFieldDatePicker.shared.didTapDoneAction = { [weak self] (picker) in
                let topOffset = CGPoint(x: 0, y: 0)
                self?.scrollView.setContentOffset(topOffset, animated: true)
                self?.dobTF.lineColor = UIColor.whiteTwo
            }
            return false
        }
        return true
    }

    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: self.dobTF.frame.maxY)
        scrollView.setContentOffset(bottomOffset, animated: true)
        self.dobTF.lineColor = UIColor(named: "purpleyPinkTwo-50") ?? .lightGray
    }
}


//MARK:- CUSTOM NAVIGATION VIEW DELEGATE
extension AddTravelBuddyVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressLeft button: UIButton) {
        
    }
}
extension AddTravelBuddyVC: AlertProtocol {
     fileprivate func addTravelBuddy() {
           CustomLoader.shared.show()
           self.viewModel.addTravelBuddy { [weak self] (result) in
               CustomLoader.shared.hide()
               guard let `self` = self else {
                   return
               }
               switch result {
               case .success(_):
                   //Handle UI or navigation
                   self.showAlertWithText(self.viewModel.responseModel?.message ?? "", buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
                       self.delegate?.reloadTable()
                       self.navigationController?.popViewController(animated: true)
                   }
                   return
               case .failure(let error):
                   self.showAlertWithText(error.message)
               }
           }
       }

    func addTravelBuddyMul() {
        CustomLoader.shared.show()
        let newHeaders: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")",
            "Content-Type": "multipart/form-data"
        ]

        let param = self.viewModel.requestModel

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data("\(param.name ?? "")".utf8), withName: "name")
            multipartFormData.append(Data("\(param.email ?? "")".utf8), withName: "email")
        },to: "http://ec2-3-145-217-61.us-east-2.compute.amazonaws.com/api/travel-buddy/store", method: .post, headers: newHeaders).responseJSON { response in
            print(response)
            switch response.result {
            case .success(let json):
                CustomLoader.shared.hide()
                if let dict = json as? [String:Any], let message = dict["message"] as? String {
                    self.showAlertWithText(message, buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
                        self.delegate?.reloadTable()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            case .failure(let error):
                print(error)
                CustomLoader.shared.hide()
                self.showAlertWithText(error.localizedDescription)
            }
        }
    }
}
