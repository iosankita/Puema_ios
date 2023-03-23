//
//  SelectGenderVC.swift
//  Pneuma
//
//  Created by iTechnolabs on 17/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

protocol SelectGenderDelegate {
    func setSelectedGender(gender:String)
}

class SelectGenderVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    // MARK: - VARIABLES
    private var genderClassButtonsArray = [UIButton]()
    var selectedGender: String = ""
    var delegate: SelectGenderDelegate?
    var index : Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()

         self.genderClassButtonsArray = [maleButton,
               femaleButton]

        switch selectedGender{
        case "Male":
            self.maleButton.isSelected = true
            self.femaleButton.isSelected = false
            break
        case "Female":
            self.maleButton.isSelected = false
            self.femaleButton.isSelected = true
            break
        default:
            break
        }
    }
    
    //MARK: - UIButton Action
    @IBAction func selectGenderButtonAction(_ sender: UIButton) {
        self.genderClassButtonsArray.forEach({$0.isSelected = false})
        sender.isSelected = true
    }

    @IBAction func selectButtonAction(_ sender: UIButton) {

        self.delegate?.setSelectedGender(gender: maleButton.isSelected ? "Male" : "Female")
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
