//
//  ChooseAddressTableCell.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class ChooseAddressTableCell: UITableViewCell {
    // MARK: - IBOUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    
    // MARK: - CLASS LIFE CYCLE
        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func setupCell(model: ChooseAddressDataModel) {
        if let subtitle = model.subtitle {
            self.subtitleLabel.text = subtitle
        }else {
            self.subtitleLabel.isHidden = true
        }
        self.titleLabel.text = model.title
        self.titleImageView.image = model.image
    }
}
