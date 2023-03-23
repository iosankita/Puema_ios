//
//  MyRidesTableCell.swift
//  Pneuma
//
//  Created by Jatin on 16/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class MyRidesTableCell: UITableViewCell {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var rideTypeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var currencyTypeLabel: UILabel!
    @IBOutlet weak var cardInfoLabel: UILabel!
    
    @IBOutlet weak var driverStatusButton: UIButton!
    
    @IBOutlet weak var driverInfoView: UIView!
    @IBOutlet weak var driverStatusView: UIView!
    @IBOutlet weak var rideRouteView: UIView!
    @IBOutlet weak var routeDottedLineView: UIView!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var rideTypeContainerView: UIView!
    
    @IBOutlet weak var driverImageView: UIImageView!
    @IBOutlet weak var rideTypeImageView: UIImageView!
    
    @IBOutlet weak var rideTypeStackView: UIStackView!

    // MARK: - VIEW LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.drawDottedLine()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func setupCell(model: RideModel) {
        self.driverNameLabel.text = model.rider_name
        self.ratingLabel.text = "\(model.rider_rating ?? 0.0)"
        self.originLabel.text = model.pickup_location
        self.destinationLabel.text = model.drop_location
        self.dateTimeLabel.text = model.pickup_time
        self.amountLabel.text = "\(model.price ?? 0)"

    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func drawDottedLine() {
        let x = self.routeDottedLineView.center.x
        self.routeDottedLineView.drawDottedLine(start: CGPoint(x: x, y: 0), end: CGPoint(x: x, y: self.routeDottedLineView.frame.maxY), color: .lightBlueGrey40Opacity)
    }
}
