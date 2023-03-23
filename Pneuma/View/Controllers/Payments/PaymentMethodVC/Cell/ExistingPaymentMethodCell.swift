//
//  ExistingPaymentMethodCell.swift
//  Pneuma
//
//  Created by Jatin on 17/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class ExistingPaymentMethodCell: UITableViewCell {

    // MARK: - IBOUTLETS
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    
    // MARK: - VIEW LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func setupCell(model: ExistingPaymentMethodDataModel) {
        self.titleLabel.text = model.title
        self.separator.isHidden = !model.separator
        self.radioButton.isSelected = model.selected
    }
}
