//
//  MyTripsCell.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class MyTripsCell: UITableViewCell {
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupContent(_ model: TripModel) {
        self.sourceLabel.text = model.origin
        self.destinationLabel.text = model.destination
        self.dateLabel.text = model.departure_date?.getDate2()?.getStringFullDate2(format: .tripDate, timeZone: .current)
    }
    
}
