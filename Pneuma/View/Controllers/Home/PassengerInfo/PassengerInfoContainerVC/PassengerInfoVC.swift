//
//  PassengerInfoVC.swift
//  Pneuma
//
//  Created by Jatin on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class PassengerInfoVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var stepOneButton: UIButton!
    @IBOutlet weak var stepTwoButton: UIButton!
    @IBOutlet weak var stepThreeButton: UIButton!
    @IBOutlet weak var stepNumberLabel: UILabel!
    @IBOutlet weak var stepTitleLabel: UILabel!
    @IBOutlet weak var stepTwoLine: UIView!
    @IBOutlet weak var stepThreeLine: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navigation: CustomNavigationView!
    
    // MARK: - VARIABLES
    var viewModel = PassengerInfoVM()
    var numberOfBookSeat : Int? = 0
    var objFlightSearchResponseData : FlightSearchResponseData?
    var arrPassengerList : [PassangerDict]!
    var numberOfAdults : Int? = 0
    var numberOfChildren : Int? = 0
    var numberOfInfants : Int? = 0
    
    // MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addPersonalInfoVC()
        self.registerForBackButton()
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - PRIVATE FUNCTIONS
    private func registerForBackButton() {
        self.navigation.delegate = self
    }
    
    private func changeStep() {
        switch self.viewModel.currentStep {
        
        case .personalInfo:
            self.addPersonalInfoVC()
            self.stepOneButton.isSelected = false
            self.stepTwoButton.isSelected = false
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.stepThreeLine.backgroundColor = .lightBlueGreyTwo
            }
        case .contactInfo:
            self.stepTwoButton.setBackgroundImage(UIImage(named: "stepTwoPurpleBG"), for: .selected)
            self.stepOneButton.isSelected = true
            self.stepTwoButton.isSelected = true
            self.stepThreeButton.isSelected = false
            self.addContactInfoVC()
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.stepThreeLine.backgroundColor = .barney
            }
        case .payment:
            self.stepTwoButton.setBackgroundImage(UIImage(named: "stepComplete"), for: .selected)
            self.stepThreeButton.isSelected = true
            self.addPaymentMethodVC()
        }
        self.stepNumberLabel.text = self.viewModel.currentStep.stepNumberText
        self.stepTitleLabel.text = self.viewModel.currentStep.stepTitleText
    }
    
    private func addPersonalInfoVC() {
        let vc = UIStoryboard.loadPassengerPersonalInfoVC()
        vc.delegate = self
        vc.numberOfBookSeat = numberOfBookSeat
        vc.numberOfAdults = numberOfAdults
        vc.numberOfChildren = numberOfChildren
        vc.numberOfInfants = numberOfInfants
        vc.objFlightSearchResponseData = objFlightSearchResponseData
        self.addChildVC(vc, toContainerView: self.containerView)
    }
    
    private func addContactInfoVC() {
        let vc = UIStoryboard.loadPassengerContactInfoVC()
        vc.delegate = self
        vc.numberOfBookSeat = numberOfBookSeat
        vc.numberOfAdults = numberOfAdults
        vc.numberOfChildren = numberOfChildren
        vc.numberOfInfants = numberOfInfants
        vc.objFlightSearchResponseData = objFlightSearchResponseData
        vc.arrPassengerList = arrPassengerList
        self.addChildVC(vc, toContainerView: self.containerView)
    }
    
    private func addPaymentMethodVC() {
        let vc = UIStoryboard.loadPaymentInfoVC()
        vc.delegate = self
        vc.numberOfBookSeat = numberOfBookSeat
        vc.numberOfAdults = numberOfAdults
        vc.numberOfChildren = numberOfChildren
        vc.numberOfInfants = numberOfInfants
        vc.arrPassengerList = arrPassengerList
        vc.objFlightSearchResponseData = objFlightSearchResponseData
        self.addChildVC(vc, toContainerView: self.containerView)
    }

}

// MARK: - NAVIGATION VIEW DELEGATE
extension PassengerInfoVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressLeft button: UIButton) {
        if self.viewModel.currentStep == .personalInfo {
            self.navigationController?.popViewController(animated: true)
        }else {
            self.viewModel.gotoPreviousStep()
            self.changeStep()
        }
    }
}

// MARK: - PASSENGER PERSONAL INFO VC DELEGATE
extension PassengerInfoVC: PassengerPersonalInfoVCDelegate {
    func vc(_ vc: PassengerPersonalInfoVC, didPressNext button: UIButton, arrData: [PassangerDict]) {
        self.arrPassengerList = arrData
        self.viewModel.gotoNextStep()
        self.changeStep()
    }
    
}

// MARK: - PASSENGER CONTACT INFO VC DELEGATE
extension PassengerInfoVC: PassengerContactInfoVCDelegate {
    func vc(_ vc: PassengerContactInfoVC, didPressNext button: UIButton, arrData: [PassangerDict]) {
        self.arrPassengerList = arrData
        self.viewModel.gotoNextStep()
        self.changeStep()
    }
    
}

// MARK: - PAYMENT INFO VC DELEGATE
extension PassengerInfoVC: PaymentInfoVCDelegate {
    func vc(_ vc: PaymentInfoVC, didPressAddPayment button: UIButton) {
        let vc = UIStoryboard.loadAddPaymentMethodVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func vc(_ vc: PaymentInfoVC, didPressComplete button: UIButton) {
//        let vc = UIStoryboard.loadFlightBookingCompletedVC()
//        self.navigationController?.pushViewController(vc, animated: true)
        self.gotoNextStep()
    }
    
    private func gotoNextStep() {
        
        AppCache.shared.selectedBookingOptions.completeCurrentStep()
        if let vc = AppCache.shared.selectedBookingOptions.nextController() {
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = UIStoryboard.loadFlightBookingCompletedVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
