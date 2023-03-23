//
//  HomeTableCell.swift
//  Pneuma
//
//  Created by Jatin on 26/02/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class HomeTableCell: UITableViewCell {
    
    // MARK: - IBOUTLET
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - IBACTION
    @IBAction func checkboxButtonAction(_ sender: UIButton) {
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func setupCell(model: HomeDataModel) {
        self.titleLabel.text = model.title
        self.titleImageView.image = model.image
        self.checkboxImageView.image = model.checkboxImage
        self.containerView.backgroundColor = model.backgroundColor
        self.containerView.borderColor = model.borderColor
    }
    
}
