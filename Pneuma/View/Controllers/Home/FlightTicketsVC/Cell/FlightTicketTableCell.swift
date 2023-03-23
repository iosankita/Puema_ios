//
//  FlightTicketTableCell.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class FlightTicketTableCell: UITableViewCell {

    // MARK: - IBOUTLETS
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyTypeLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startingLocationLabel: UILabel!
    @IBOutlet weak var endingLocationLabel: UILabel!
    @IBOutlet weak var flightStopsStackView: UIStackView!
    
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
    func setupCell(model: FlightBookings) {
        //self.logoImageView.image = model.logo
        self.logoImageView.kf.setImage(with: URL(string: model.airlineImage ?? ""))
        self.setupFlightStops(model: model)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setupFlightStops(model: FlightBookings) {
        self.priceLabel.text = "\(model.totalPayment ?? 0.0)"
        self.totalTimeLabel.text = model.estimatedTime ?? ""
        self.startDateLabel.text = model.departureDate?.getDate2()?.getStringFullDate2(format: .FlightTime, timeZone: .current)
        self.endTimeLabel.text = model.arrivalDate?.getDate2()?.getStringFullDate2(format: .FlightTime, timeZone: .current)
        self.startingLocationLabel.text = model.origin
        self.endingLocationLabel.text = model.destination
    
//        for _ in 0..<1 {
//            self.flightStopsStackView.removeArrangedSubviews()
//            self.flightStopsStackView.removeSubviews()
//            let stopView: FlightStopView = .loadFromNib()
//            stopView.heightAnchor.constraint(equalToConstant: 15).isActive = true
//            self.flightStopsStackView.addArrangedSubview(stopView)
//        }
    }
    
    
}
