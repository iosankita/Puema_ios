//
//  PaymentMethodView.swift
//  Pneuma
//
//  Created by Jatin on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

protocol PaymentMethodViewDelegate: class {
    func view(_ view: PaymentMethodView, didPress button: UIButton, model: PaymentMethodDataModel?)
}

class PaymentMethodView: UIView {

    // MARK: - IBOUTLETS
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var separatorView: UIView!
    
    // MARK: - VARIABLES
    var model: PaymentMethodDataModel?
    weak var delegate: PaymentMethodViewDelegate?
    
    // MARK: - CLASS LIFE CYCLE
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func setupView(model: PaymentMethodDataModel) {
        self.paymentButton.setTitle(model.title, for: .normal)
        self.separatorView.isHidden = !model.separator
    }
    
    // MARK: - IBACTIONS
    @IBAction func paymentMethodButtonAction(_ sender: UIButton) {
        self.delegate?.view(self, didPress: sender, model: self.model)
    }
}
