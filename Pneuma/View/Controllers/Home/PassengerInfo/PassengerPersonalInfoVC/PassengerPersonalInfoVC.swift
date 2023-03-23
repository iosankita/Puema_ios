//
//  PassengerPersonalInfoVC.swift
//  Pneuma
//
//  Created by Jatin on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import DropDown

struct PassangerDict : Codable {
    var fullName : String
    var first_name : String
    var middle_name : String
    var last_name : String
    var date_of_birth : String
    var gender : String
    var email : String
    var mobileNumber : String
    var countryCode : String

    init(fullName : String, first_name : String, middle_name : String, last_name : String, date_of_birth : String, gender : String, email : String = "", mobileNumber : String = "", countryCode : String = "") {
        self.fullName = fullName
        self.first_name = first_name
        self.middle_name = middle_name
        self.last_name = last_name
        self.date_of_birth = date_of_birth
        self.gender = gender
        self.email = email
        self.mobileNumber = mobileNumber
        self.countryCode = countryCode
    }
}

protocol PassengerPersonalInfoVCDelegate {
    func vc(_ vc: PassengerPersonalInfoVC, didPressNext button: UIButton, arrData: [PassangerDict])
}

class PassengerPersonalInfoVC: UIViewController, AlertProtocol {
    // MARK: - IBOUTLETS
    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var middleNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var dobTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var genderTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var selectPassengerTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var collectionViewPassangerDetail: UICollectionView!
    @IBOutlet weak var constraintCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: - VARIABLES
    var delegate: PassengerPersonalInfoVCDelegate?
    private var selectedDate: Date?
    var i : Int = 0
    var objFlightSearchResponseData : FlightSearchResponseData?
    var numberOfBookSeat : Int? = 0
    var createOrder : CreateOrderParam?
    var arrPassengerList: [PassangerDict] = [PassangerDict]()
    var selectIndex : Int = 0
    var dropDownPassenger = DropDown()
    var numberOfAdults : Int? = 0
    var numberOfChildren : Int? = 0
    var numberOfInfants : Int? = 0
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.standard.rawValue
        return formatter
    }()

    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 1...(numberOfBookSeat ?? 1) {
            arrPassengerList.append(PassangerDict(fullName: "", first_name: "", middle_name: "", last_name: "", date_of_birth: "", gender: ""))
        }

        self.pageControl.numberOfPages = numberOfBookSeat ?? 0
        self.setupCollectionView()
    }
    
    // MARK: - IBACTIONS
    @IBAction func nextButtonAction(_ sender: UIButton) {
        var passengerNumber = ""
        for (i,data) in arrPassengerList.enumerated(){
            if  i == 0  {
                passengerNumber = "first"
            }else if  i == 1  {
                passengerNumber = "second"
            }else if  i == 2  {
                passengerNumber = "third"
            }else if  i == 3  {
                passengerNumber = "fourth"
            }else if  i == 4  {
                passengerNumber = "fifth"
            }
            if data.fullName == "" || data.first_name == "" || data.middle_name == "" || data.last_name == "" || data.date_of_birth == "" || data.gender == ""  {
                if data.fullName == "" {
                    self.showAlertWithText("\(passengerNumber) passenger fullname should not be empty")
                }else if data.first_name == "" {
                    self.showAlertWithText("\(passengerNumber) passenger firstname should not be empty")
                }else if data.middle_name == "" {
                    self.showAlertWithText("\(passengerNumber) passenger middlename should not be empty")
                }else if data.last_name == "" {
                    self.showAlertWithText("\(passengerNumber) passenger lastname should not be empty")
                }else if data.date_of_birth == "" {
                    self.showAlertWithText("\(passengerNumber) passenger date of birth should not be empty")
                }else if data.gender == "" {
                    self.showAlertWithText("\(passengerNumber) passenger gender should not be empty")
                }
                return
            }
        }
        self.delegate?.vc(self, didPressNext: sender, arrData: arrPassengerList)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func registerNib() {
        let collNib = UINib(nibName: "PassangerListCell", bundle: nil)
        self.collectionViewPassangerDetail.register(collNib, forCellWithReuseIdentifier: "PassangerListCell")
    }

    private func setupCollectionView() {
        self.registerNib()
        self.collectionViewPassangerDetail.dataSource = self
        self.collectionViewPassangerDetail.delegate = self
    }

    func setupDropDown() {
        //<-------------------FOR ITEM------------------->
        dropDownPassenger.anchorView = collectionViewPassangerDetail
        dropDownPassenger.bottomOffset = CGPoint(x: 0, y: 10)

       
    }
}
// MARK: -  UITextField delegate methods
extension PassengerPersonalInfoVC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField.tag == 1000 {
//            dropDownPassenger.show()
//            //arrPassengerList[selectIndex].fullName = textField.text ?? ""
//            //textField.text = arrPassengerList[selectIndex].fullName
//            return false
//            //return false
//        }else
        if textField.tag == 1004 {
            let vc = UIStoryboard.loadChooseDateVC()
            vc.dateDelegate = self
            vc.isFromBookAFlightDate1 = true
            vc.selectedDate = self.selectedDate
            vc.index = selectIndex
            self.navigationController?.pushViewController(vc, animated: true)
            return false
        }else if textField.tag == 1005 {
            let vc = UIStoryboard.loadChooseGenderVC()
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            vc.index = selectIndex
            vc.selectedGender = textField.text ?? "Male"
            self.navigationController?.present(vc, animated: true, completion: nil)
            return false
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1000 {
            arrPassengerList[selectIndex].fullName = textField.text ?? ""
        }else if textField.tag == 1001 {
            arrPassengerList[selectIndex].first_name = textField.text ?? ""
        }else if textField.tag == 1002 {
            arrPassengerList[selectIndex].middle_name = textField.text ?? ""
        }else if textField.tag == 1003 {
            arrPassengerList[selectIndex].last_name = textField.text ?? ""
        }
        self.collectionViewPassangerDetail.reloadData()
    }
}

//MARK: - SelectGender Delegate
extension PassengerPersonalInfoVC: SelectGenderDelegate{
    
    func setSelectedGender(gender: String) {
        //genderTextField.text = gender
        arrPassengerList[selectIndex].gender = gender
        collectionViewPassangerDetail.reloadData()
    }

}

extension PassengerPersonalInfoVC: DateDelegate {
    func setDate(date: Date, from: DateFrom) {
        selectedDate = date
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.arrPassengerList[selectIndex].date_of_birth = self.dateFormatter.string(from: selectedDate ?? Date())
        collectionViewPassangerDetail.reloadData()
        //self.dobTextField.text = self.dateFormatter.string(from: selectedDate ?? Date())
    }
}

extension PassengerPersonalInfoVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPassengerList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell : PassangerListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PassangerListCell", for: indexPath) as? PassangerListCell else {
            return UICollectionViewCell()
        }
        cell.txtSelectPassanger.text = arrPassengerList[indexPath.row].fullName
        cell.txtSelectPassanger.delegate = self
        cell.txtSelectPassanger.tag = 1000
        cell.txtEnterName.text = arrPassengerList[indexPath.row].first_name
        cell.txtEnterName.delegate = self
        cell.txtEnterName.tag = 1001
        cell.txtEnterMiddleName.text = arrPassengerList[indexPath.row].middle_name
        cell.txtEnterMiddleName.delegate = self
        cell.txtEnterMiddleName.tag = 1002
        cell.txtEnterLastName.text = arrPassengerList[indexPath.row].last_name
        cell.txtEnterLastName.delegate = self
        cell.txtEnterLastName.tag = 1003
        cell.txtSelectDOB.text = arrPassengerList[indexPath.row].date_of_birth
        cell.txtSelectDOB.delegate = self
        cell.txtSelectDOB.tag = 1004
        cell.txtSelectGender.text = arrPassengerList[indexPath.row].gender
        cell.txtSelectGender.delegate = self
        cell.txtSelectGender.tag = 1005
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionViewPassangerDetail.width, height:self.collectionViewPassangerDetail.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension PassengerPersonalInfoVC: UIScrollViewDelegate {
    //MARK:- UIScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UICollectionView.self) {
            pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
            selectIndex = pageControl.currentPage
        }
    }
}
