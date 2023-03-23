//
//  MenuCell.swift
//  Pneuma
//
//  Created by Chitra on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        titleText.textColor = selected ? #colorLiteral(red: 0.5647058824, green: 0.1137254902, blue: 0.7098039216, alpha: 1) : UIColor.warmGreyTwo
        activeLabel.isHidden = !(selected)
    }

}
