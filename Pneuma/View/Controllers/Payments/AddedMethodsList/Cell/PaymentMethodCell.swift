//
//  PaymentMethodCell.swift
//  Pneuma
//
//  Created by Chitra on 15/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

protocol PaymentActionDelegate: class {
    func didPressDelete(_ sender: PaymentMethodCell, index: Int)
    func didPressEdit(_ sender: PaymentMethodCell, index: Int)
}

class PaymentMethodCell: UITableViewCell {

    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var paymentTitle: UILabel!
    @IBOutlet weak var expireLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var expiredLabelHeight: NSLayoutConstraint!
    
    weak var delegate: PaymentActionDelegate?
    var index: Int?
    var hideExpireLabel: Bool = true {
        didSet {
            self.expiredLabelHeight.constant = (hideExpireLabel) ? 0 : 20
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.radioButton.isSelected = selected
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        self.delegate?.didPressDelete(self, index: index ?? -1)
    }

    @IBAction func editAction(_ sender: UIButton) {
        self.delegate?.didPressEdit(self, index: index ?? -1)
    }
    
    func setupContent(model: PaymentMethodModel, index: Int) {
        self.index = index
        self.paymentTitle.text = model.title
        self.hideExpireLabel = !(model.isExpired)
    }
    
}
