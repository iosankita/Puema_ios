//
//  AddPaymentMethodCollectionCell.swift
//  Pneuma
//
//  Created by Jatin on 09/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class AddPaymentMethodCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var imageview: UIImageView!
    
    // MARK: - CLASS LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - INTERNAL FUNCTIONS
    func setupCell(model: AddPaymentMethodDataModel) {
        self.imageview.image = model.image
    }
}
