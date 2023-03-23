//
//  RoomDetailTableCell.swift
//  Pneuma
//
//  Created by iTechnolabs on 17/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class RoomDetailTableCell: UITableViewCell {

    @IBOutlet weak var lblRoomName: UILabel!
    @IBOutlet weak var lblRoomBedType: UILabel!
    @IBOutlet weak var lblRoomDescription: UILabel!
    @IBOutlet weak var lblRoomPrice: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
