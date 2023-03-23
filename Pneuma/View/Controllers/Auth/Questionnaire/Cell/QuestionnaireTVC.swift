//
//  QuestionnaireTVC.swift
//  Pneuma
//
//  Created by Chitra on 01/03/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit

enum SeasonOptions: Int {
    case winter
    case spring
    case summer
    case fall
    
    var displayString: String {
        switch self {
        case .winter:
            return "Winter"
        case .spring:
            return "Spring"
        case .summer:
            return "Summer"
        case .fall:
            return "Fall"
        }
    }
}

enum TravelReason: Int {
    case business
    case recreation
    
    var displayString: String {
        switch self {
        case .business:
            return "Business"
        case .recreation:
            return "Recreation"
        }
    }
}

class QuestionnaireTVC: UITableViewCell {
    
    //MARK:- IBOUTLETS
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var choiceView: UIView!
    @IBOutlet weak var bottomOptionsView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var numberButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var detailView: UIStackView!
    @IBOutlet weak var textField: UITextField!
    
    ///Options UI
    @IBOutlet var optionLabel: [UILabel]!
    @IBOutlet var optionButton: [UIButton]!
    
    //MARK:- VARIABLES
    var index: Int = 0
    var selectedOptionTag: Int? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func setupCell(model: QuestionsDataModel, index: Int) {
        self.index = index
        textField.text = ""
        if index == 0 {
            textField.placeholder = "Enter country"
        }else if index == 1 {
            textField.placeholder = "Enter your dream destination"
        }else if index == 2 {
            textField.placeholder = "From previous travel experience"
        }else if index == 3 {
            textField.placeholder = "Ex: January, February…"
        }else if index == 4 {
            textField.placeholder = "Ex: Business, Vacation, Holiday…"
        }else if index == 5 {
            textField.placeholder = "Ex: Historical & Heritage,Snorkeling & Deep-sea…"
        }
        questionLabel.text = model.question
        numberButton.setTitle(get2DigitIndex(), for: .normal)
        
        progressLabel.backgroundColor = (model.state == .inComplete) ? AppColor.questionnaireGray.getColor() : AppColor.questionnaireOrange.getColor()
        detailView.isHidden = !(model.state == .active)
        progressLabel.isHidden = (model.isLast)
        
        switch model.state {
        case .active:
            numberButton.setTitleColor(AppColor.questionnaireOrange.getColor(), for: .normal)
            self.setupOptions(model: model)
        case .inComplete:
            numberButton.setTitleColor(AppColor.questionnaireGray.getColor(), for: .normal)
        case .complete:
            numberButton.setTitleColor(.white, for: .normal)
        }
        //set color state wise
        numberButton.backgroundColor = (model.state == .complete) ? AppColor.questionnaireOrange.getColor() : UIColor.clear
        numberButton.borderColor = (model.state == .inComplete) ? AppColor.questionnaireGray.getColor() : AppColor.questionnaireOrange.getColor()
        
        
        if model.state == .active {
            self.textFieldView.isHidden = !(model.type == .textfield)
            self.choiceView.isHidden = (model.type == .textfield)
        }
    }
    
    @IBAction func checkBoxAction(_ sender: UIButton) {
        sender.isSelected = !(sender.isSelected)
        if sender.isSelected {
            selectedOptionTag = sender.tag
        } else {
            selectedOptionTag = nil
        }
    }
    
    private func get2DigitIndex() -> String {
        let integerAsString = String(index + 1)
        if index < 10 {
            return "0\(integerAsString)"
        }
        return integerAsString
    }
    
    private func updateUI() {
        for button in optionButton {
            button.isSelected = false
        }
        if let selectedIndex = selectedOptionTag {
            optionButton[selectedIndex].isSelected = true
        }
    }
    
    private func setupOptions(model: QuestionsDataModel) {
        for i in 0..<optionLabel.count {
            if model.type == .travelPurpose {
                if i < 2 { //only 2 options to show
                    let label = optionLabel.filter({ $0.tag == i }).first
                    label?.text = (TravelReason(rawValue: i)?.displayString ?? "")
                }
            } else {
                let label = optionLabel.filter({ $0.tag == i }).first
                label?.text = (SeasonOptions(rawValue: i)?.displayString ?? "")
            }
        }
        bottomOptionsView.isHidden = (model.type == .travelPurpose)
    }
}
