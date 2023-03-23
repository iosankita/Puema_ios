//
//  AnnieCell.swift
//  Pneuma
//
//  Created by Infinity S on 24/12/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class AnnieCell: UITableViewCell {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblAnnieVoice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
