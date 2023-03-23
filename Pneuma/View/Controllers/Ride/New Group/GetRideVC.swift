//
//  GetRideVC.swift
//  Pneuma
//
//  Created by iTechnolabs on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import AWSLex

class GetRideVC: UIViewController , AWSLexVoiceButtonDelegate{

    // MARK: - IBOUTLETS
    @IBOutlet weak var askAnnyButton: UIButton!
    private var voiceButton: AWSLexVoiceButton!
    
    // MARK: - VARIABLES
    let viewModel = BookRideVM()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.voiceButton = AWSLexVoiceButton(frame: CGRect(x: 344, y: 717, width: 70, height: 70))
        self.voiceButton.backgroundColor = .red
        self.voiceButton.delegate = self
        self.voiceButton.microphoneImageColor = .blue
        self.voiceButton.isUserInteractionEnabled = true
        self.voiceButton.isHidden = true
        self.view.addSubview(self.voiceButton)
        self.view.bringSubviewToFront(self.voiceButton)
    }
    
    // MARK: - IBACTIONS
    @IBAction func pickupAddressButtonAction(_ sender: UIButton) {
        self.gotoChooseLocation(type: .pickupAddress)
    }
    
    @IBAction func dropOffAddressButtonAction(_ sender: UIButton) {
        self.gotoChooseLocation(type: .dropoffAddress)
    }
    
    @IBAction func dateButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.loadChooseDateVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.setupView(isTransparent: true, hideSelectedDateView: true, hideNavigationView: true, disableDismissButton: false, hideTime: false)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func paymentMethodButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.loadPaymentMethodVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func commentButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func completeButtonAction(_ sender: UIButton) {
        setDataToVM()
        if let message = self.viewModel.validation() {
           self.showAlertWithText(message)
        }else{
           self.bookRide()
        }
    }
    
    @IBAction func askAnnieButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.loadAskAnnieVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func voiceButton(_ button: AWSLexVoiceButton, on response: AWSLexVoiceButtonResponse) {
        DispatchQueue.main.async(execute: {
            // `inputTranscript` is the transcript of the voice input to the operation
            if let inputTranscript = response.inputTranscript {
                print("Input Transcript: " + inputTranscript)
                
            }
            if let outputText = response.outputText {
                print("Output Transcript: " + outputText)
                
            } else {
               
            }
        })
    }
    
    public func voiceButton(_ button: AWSLexVoiceButton, onError error: Error) {
        print("error \(error)")
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func gotoChooseLocation(type: ChooseAddressTypeEnum) {
        let vc = UIStoryboard.loadChooseAddressVC()
        let vm = ChooseAddressVM(locationType: type)
        vc.setupViewModel(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func gotoNextStep() {
        
        gotoSearchDriverVC()
        
        /*AppCache.shared.selectedBookingOptions.completeCurrentStep()
        if let vc = AppCache.shared.selectedBookingOptions.nextController() {
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = UIStoryboard.loadPayVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }*/
    }
    
    private func setDataToVM(){
        self.viewModel.requestModel.user_id = AppCache.shared.currentUser?.id ?? 1
        self.viewModel.requestModel.payment_method_id = 1
        self.viewModel.requestModel.pickup_location = "Johar Town, lahore"
        self.viewModel.requestModel.drop_location = "DHA"
        self.viewModel.requestModel.pickup_time = "2021-10-27 12:54:11"
        self.viewModel.requestModel.drop_time = "2021-10-27 12:54:11"
        self.viewModel.requestModel.price = 2000
        self.viewModel.requestModel.rider = RiderModel()
        self.viewModel.requestModel.rider?.name = "Mario"
        self.viewModel.requestModel.rider?.image = ""
        self.viewModel.requestModel.rider?.phone = "03122211212"
        self.viewModel.requestModel.rider?.email = "mario@gmail.com"
        self.viewModel.requestModel.rider?.unique_id = 4323
        self.viewModel.requestModel.rating = 4.5
        
    }
}

extension GetRideVC: SearchDriverDelegate {
    func didCancelRide() {
        self.dismiss(animated: true, completion: nil)
        self.gotoCanceLResonVC()
    }
    
    func didSearchAgain() {
        self.dismiss(animated: true, completion: nil)
        self.gotoSearchDriverVC()
    }
    
    func gotoCanceLResonVC() {
        let vc = UIStoryboard.loadCancelRideReasonVC()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func gotoSearchDriverVC() {
        let vc = UIStoryboard.loadSearchDriverVC()
        vc.status = .searching
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}
extension GetRideVC: AlertProtocol {
     fileprivate func bookRide() {
           CustomLoader.shared.show()
           self.viewModel.bookRide { [weak self] (result) in
               CustomLoader.shared.hide()
               guard let `self` = self else {
                   return
               }
               switch result {
               case .success(_):
                   //Handle UI or navigation
                   self.showAlertWithText(self.viewModel.responseModel?.message ?? "", buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
                       self.gotoNextStep()
                   }
                   return
               case .failure(let error):
                   self.showAlertWithText(error.message)
               }
           }
       }
}
