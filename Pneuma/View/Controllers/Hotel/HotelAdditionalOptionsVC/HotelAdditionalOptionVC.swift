//
//  HotelAdditionalOptionVC.swift
//  Pneuma
//
//  Created by Jatin on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

protocol HotelAdditionalOptionDelegate {
    func setPeopleAndRoom(adults:Int,children:Int,rooms:Int)
}

class HotelAdditionalOptionVC: UIViewController, AlertProtocol {

    // MARK: - IBOUTLETS
    @IBOutlet weak var adultsMinusButton: UIButton!
    @IBOutlet weak var adultsPlusButton: UIButton!
    @IBOutlet weak var childrenMinusButton: UIButton!
    @IBOutlet weak var childrenPlusButton: UIButton!
    @IBOutlet weak var roomsMinusButton: UIButton!
    @IBOutlet weak var roomsPlusButton: UIButton!
    @IBOutlet weak var adultsCountLabel: UILabel!
    @IBOutlet weak var childrenCountLabel: UILabel!
    @IBOutlet weak var roomsCountLabel: UILabel!
        
    @IBOutlet weak var navigation: CustomNavigationView!
    
    // MARK: - VARIABLES
    private var numberOfAdults:Int = 1
    private var numberOfChildren:Int = 0
    private var numberOfRoom:Int = 1

    var delegate : HotelAdditionalOptionDelegate?
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        roomsCountLabel.text = "\(numberOfRoom)"
    }
    
    // MARK: - IBACTIONS
    ///Single action for all minus button actions
    @IBAction func minusButtonAction(_ sender: UIButton) {
        switch sender.tag{
        case 0:
            if numberOfAdults > 0{
                numberOfAdults -= 1
                adultsCountLabel.text = "\(numberOfAdults)"
            }
            break
        case 1:
            if numberOfChildren > 0{
                numberOfChildren -= 1
                childrenCountLabel.text = "\(numberOfChildren)"
            }
            break
        case 2:
            if numberOfRoom > 0{
                numberOfRoom -= 1
                roomsCountLabel.text = "\(numberOfRoom)"
            }
            break
        default:
            break
        }
    }
    
    ///Single action for all plus button actions
    @IBAction func plusButtonAction(_ sender: UIButton) {
//        if numberOfAdults + numberOfChildren == 5 {
//            self.showAlertWithText("total passenger can't be more than 5")
//            return
//        }
        switch sender.tag{
        case 0:
            numberOfAdults += 1
            adultsCountLabel.text = "\(numberOfAdults)"
            break
        case 1:
            numberOfChildren += 1
            childrenCountLabel.text = "\(numberOfChildren)"
            break
        case 2:
            numberOfRoom += 1
            roomsCountLabel.text = "\(numberOfRoom)"
            break
        default:
            break
        }
    }
    
    @IBAction func applyButtonAction(_ sender: UIButton) {
        self.delegate?.setPeopleAndRoom(adults: numberOfAdults, children: numberOfChildren, rooms: numberOfRoom)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - PRIVATE FUNCTIONS
}

