//
//  FlightStopView.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class FlightStopView: UIView {

    // MARK: - IBOUTLETS
    @IBOutlet weak var dottedLineView: UIView!
    @IBOutlet weak var plane: UIImageView!
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.drawDottedLine()
    }
    
    
    // MARK: - PRIVATE FUNCTIONS
    private func drawDottedLine() {
        let y = self.dottedLineView.center.y
        self.dottedLineView.drawDottedLine(start: CGPoint(x: 0, y: y), end: CGPoint(x: self.dottedLineView.frame.maxX, y: y), color: .lightBlueGrey40Opacity)
    }
}
