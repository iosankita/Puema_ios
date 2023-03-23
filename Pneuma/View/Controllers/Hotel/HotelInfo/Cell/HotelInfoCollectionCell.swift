//
//  HotelInfoCollectionCell.swift
//  Pneuma
//
//  Created by iTechnolabs on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class HotelInfoCollectionCell: UICollectionViewCell {

    // MARK: - IBOUTLETS
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: - CLASS LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - INTERNAL FUNCTIONS
    func setupCell(title: String?) {
        self.infoLabel.text = title
    }
}
