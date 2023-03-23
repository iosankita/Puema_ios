//
//  HaltTableCell.swift
//  Pneuma
//
//  Created by Infinity S on 29/01/22.
//  Copyright © 2022 Jatin. All rights reserved.
//

import UIKit

class HaltTableCell: UITableViewCell {

    @IBOutlet weak var lblAirportName: UILabel!
    @IBOutlet weak var lblAirportIataCode: UILabel!
    @IBOutlet weak var lblArrivalTime: UILabel!
    @IBOutlet weak var lblRestTime: UILabel!
    @IBOutlet weak var lblDepartureTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
