//
//  AdditionalOptionVC.swift
//  Pneuma
//
//  Created by Jatin on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

protocol AdditionalOptionDelegate {
    func setSeatTypeAndPeople(seatType:String, Adults:Int,Children:Int,Infants:Int, childrenAge : NSMutableArray)
}


class AdditionalOptionVC: UIViewController, AlertProtocol {

    // MARK: - IBOUTLETS
    @IBOutlet weak var adultsMinusButton: UIButton!
    @IBOutlet weak var adultsPlusButton: UIButton!
    @IBOutlet weak var childrenMinusButton: UIButton!
    @IBOutlet weak var childrenPlusButton: UIButton!
    @IBOutlet weak var infantsMinusButton: UIButton!
    @IBOutlet weak var infantsPlusButton: UIButton!
    @IBOutlet weak var adultsCountLabel: UILabel!
    @IBOutlet weak var childrenCountLabel: UILabel!
    @IBOutlet weak var infantsCountLabel: UILabel!
    
    @IBOutlet weak var economyButton: UIButton!
    @IBOutlet weak var premiumEconomyButton: UIButton!
    @IBOutlet weak var businessButton: UIButton!
    @IBOutlet weak var firstClassButton: UIButton!
    @IBOutlet weak var colVwAge: UICollectionView!
    @IBOutlet weak var vwAge: UIView!
    @IBOutlet weak var navigation: CustomNavigationView!
    
    // MARK: - VARIABLES
    private var cabinClassButtonsArray = [UIButton]()
     var numberOfAdults:Int = 1
     var numberOfChildren:Int = 0
    private var numberOfInfants:Int = 0
    private var selectedClass: String = ""
    var userSelectedClass: String = ""
    var arrChildrenAge = NSMutableArray() //[Int]?
    var delegate : AdditionalOptionDelegate?

    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.delegate = self
        vwAge.isHidden = true
        self.cabinClassButtonsArray = [economyButton,
                                       premiumEconomyButton,
                                       businessButton,
                                       firstClassButton]
        self.setUI()
        colVwAge.delegate =  self
        colVwAge.dataSource = self
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
                arrChildrenAge.removeLastObject()
                colVwAge.reloadData()
                if arrChildrenAge.count == 0 {
                    vwAge.isHidden = true
                }
            }
            break
        case 2:
            if numberOfInfants > 0{
                numberOfInfants -= 1
                infantsCountLabel.text = "\(numberOfInfants)"
            }
            break
        default:
            break
        }

    }
    
    ///Single action for all plus button actions
    @IBAction func plusButtonAction(_ sender: UIButton) {
        if numberOfAdults + numberOfChildren + numberOfInfants == 5 {
            self.showAlertWithText("total passenger can't be more than 5")
            return
        }
        switch sender.tag{
        case 0:
            numberOfAdults += 1
            adultsCountLabel.text = "\(numberOfAdults)"
            break
        case 1:
            numberOfChildren += 1
            childrenCountLabel.text = "\(numberOfChildren)"
            arrChildrenAge.add("Select Age")
            //append(1)
            if arrChildrenAge.count == 0 {
                vwAge.isHidden = true
            }else {
                vwAge.isHidden = false
            }
            colVwAge.reloadData()
            break
        case 2:
            numberOfInfants += 1
            infantsCountLabel.text = "\(numberOfInfants)"
            break
        default:
            break
        }
    }
    
    ///Single action for all cabin class button actions
    @IBAction func cabinClassButtonAction(_ sender: UIButton) {
        self.cabinClassButtonsArray.forEach({$0.isSelected = false})
        sender.isSelected = true
        switch sender.tag{
        case 101:
            selectedClass = "Y"//"ECONOMY"
            break
        case 102:
            selectedClass = "S"//"PREMIUM ECONOMY"
            break
        case 103:
            selectedClass = "C"//"BUSINESS"
            break
        case 104:
            selectedClass = "F"//"FIRST-CLASS"
            break
        default:
            break
            //Premium First (P), First (F), Premium Business (J), Business (C), Premium Economy (S) or Economy (Y)
        }
    }

    @IBAction func applyButtonAction(_ sender: UIButton) {
        if arrChildrenAge.contains("Select Age"){
            self.showAlertWithText("Please enter children age")
            return
        }
        if selectedClass == "" {
            if economyButton.isSelected == true {
                selectedClass = "Y"//"ECONOMY"
            }else if premiumEconomyButton.isSelected == true {
                selectedClass = "S"//"PREMIUM ECONOMY"
            }else if businessButton.isSelected == true {
                selectedClass = "C"//"BUSINESS"
            }else if firstClassButton.isSelected == true {
                selectedClass = "F"//"FIRST-CLASS"
            }
        }
        self.delegate?.setSeatTypeAndPeople(seatType: selectedClass, Adults: numberOfAdults, Children: numberOfChildren, Infants: numberOfInfants, childrenAge: arrChildrenAge)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setUI(){
        adultsCountLabel.text = "\(numberOfAdults)"
        childrenCountLabel.text = "\(numberOfChildren)"
        infantsCountLabel.text = "\(numberOfInfants)"

        switch userSelectedClass{
        case "Y":
            economyButton.isSelected = true
            premiumEconomyButton.isSelected = false
            businessButton.isSelected = false
            firstClassButton.isSelected = false
            break
        case "S":
            economyButton.isSelected = false
            premiumEconomyButton.isSelected = true
            businessButton.isSelected = false
            firstClassButton.isSelected = false
            break
        case "C":
            economyButton.isSelected = false
            premiumEconomyButton.isSelected = false
            businessButton.isSelected = true
            firstClassButton.isSelected = false
            break
        case "F":
            economyButton.isSelected = false
            premiumEconomyButton.isSelected = false
            businessButton.isSelected = false
            firstClassButton.isSelected = true
            break
        default:
            break
        }
    }
}

// MARK: - NAVIGATION VIEW DELEGATE
extension AdditionalOptionVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressRight button: UIButton) {

    }
}
extension AdditionalOptionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return /arrChildrenAge.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell : AgeCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "AgeCVC", for: indexPath) as? AgeCVC else {
            return UICollectionViewCell()
        }
        cell.lblAge.text = "\(arrChildrenAge[indexPath.item])"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let alertBox = UIAlertController.init(title: "Select Age", message: "Enter Child Age", preferredStyle: .alert)
          alertBox.addTextField { (textField) in
              textField.keyboardType = .decimalPad
          }
          alertBox.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil))
          alertBox.addAction(UIAlertAction.init(title: "Add Age", style: .default, handler: { [weak self] (_) in
              let quantityEntered = Int(/alertBox.textFields?.first?.text)
              if let value = quantityEntered {
                  self?.arrChildrenAge.removeObject(at: indexPath.row)
                  self?.arrChildrenAge.insert(value, at: indexPath.row)
                  self?.colVwAge.reloadData()
              } else {
                  self?.showAlertWithText("Please enter only numeric digits.")
              }
          }))
          UIApplication.shared.keyWindow?.rootViewController?.present(alertBox, animated: true, completion: nil)
     
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.colVwAge.width/3, height:self.colVwAge.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
