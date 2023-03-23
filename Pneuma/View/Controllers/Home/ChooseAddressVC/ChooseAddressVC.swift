//
//  ChooseAddressVC.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import CoreLocation
import Amadeus
import DropDown

enum From {
    case flight
    case hotel
    case ride
}


protocol FlightSelectedDelegate {
    func setFlight(airpotName:String, cityName:String, from:ChooseAddressTypeEnum)
}

protocol HotelDelegate {
    func setHotel(cityName:String)
}

class ChooseAddressVC: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {

    // MARK: - IBOUTLETS
    @IBOutlet weak var selectedAddressLabel: UILabel!
    @IBOutlet weak var txtCustomSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressImageView: UIImageView!
    @IBOutlet weak var selectAddressOnMapView: UIView!
    
    // MARK: - VARIABLES
    private let cellIdentifier = "ChooseAddressTableCell"
    var viewModel: ChooseAddressVM!
    var delegate: FlightSelectedDelegate?
    var delegateHotel: HotelDelegate?
    var selectedCityName: String?

    fileprivate var locationManager: CLLocationManager!
    fileprivate var currentLocation = CLLocation()

    fileprivate var dropDownAirport = DropDown()

    var amadeus: Amadeus!
    fileprivate var selectedIndex : Int = 0
    var isfrom : From! = .flight

    // MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCustomSearch.delegate = self
        txtCustomSearch.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.navigationView.delegate = self
        if isfrom == .flight {
            self.setupLocationPermission()
        }
        self.setupUI()
    }
    
    // MARK: - IBACTIONS
    @IBAction func selectLocationButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func currentLocationButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func selectAddressOnMapButtonAction(_ sender: UIButton) {
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func setupViewModel(_ viewModel: ChooseAddressVM) {
        self.viewModel = viewModel
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setupTableView() {
        self.registerNib()

        self.tableView.dataSource = self.viewModel.tableDataSource
        self.tableView.delegate = self
        CustomLoader.shared.show()
        self.viewModel.getList(lat: self.currentLocation.coordinate.latitude, long: self.currentLocation.coordinate.longitude) { [weak self] (errorMsg) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            if errorMsg.isEmpty{
                DispatchQueue.main.async {
                    self.tableView.dataSource = self.viewModel.tableDataSource
                    self.tableView.reloadData()
                    // self.view.setNeedsLayout()
                }
            }
        }
    }
    
    private func registerNib() {
        let nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.cellIdentifier)
    }

    private func setupUI() {
        self.navigationView.titleLabel.text = self.viewModel.locationType.title
        self.descriptionLabel.text = self.viewModel.locationType.description
        self.addressImageView.image = self.viewModel.locationType.addressImage
        self.selectAddressOnMapView.isHidden = self.viewModel.locationType.isHideSelectLocationOnMapView
        //self.selectedAddressLabel.text = self.selectedCityName ?? ""
//        let deadlineTime = DispatchTime.now() + .seconds(1)
//        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
//            self.setupTableView()
//        }
        self.setupDropDown()
    }

    private func setupLocationPermission(){

        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                locationManager = CLLocationManager()
                locationManager.requestWhenInUseAuthorization()
                self.setupLocationPermission()
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
//                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
            @unknown default: break

            }
        }else{
            locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
            self.setupLocationPermission()
        }

    }

    //MARK:- CLLocationManager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        manager.stopUpdatingLocation()
        let location = locations.last! as CLLocation
        currentLocation = location
        self.setupTableView()
    }

    @objc
    func textFieldDidChange(textField: UITextField) {
        if textField.text?.count ?? 0  > 2 {
            viewModel.arrCustomList.removeAll()
            let newString = textField.text!.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
            self.viewModel.getCityList(city: newString) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.setDropDownData()//setupDropDown()
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }

    func setDropDownData() {
        if self.viewModel.tableDataSource.listArray2.count > 0 && txtCustomSearch.text != ""{
            var arrAirportName = [String]()
            switch isfrom {
            case .flight:
                for dataOfAirport in self.viewModel.tableDataSource.listArray2{
                    arrAirportName.append("\(dataOfAirport.AirportCode ?? "")  - \(dataOfAirport.City ?? "") - \(dataOfAirport.AirportName ?? "")")
                }
                break
            case .hotel:
                for dataOfAirport in self.viewModel.tableDataSource.listArray2{
                    arrAirportName.append("\(dataOfAirport.City ?? "")")
                }
                break
            default:
                break
            }
            
            dropDownAirport.dataSource = arrAirportName
            dropDownAirport.show()
        }else {
            dropDownAirport.hide()
        }
    }

    func setupDropDown() {

        //<-------------------FOR AIRPORT------------------->
        dropDownAirport.anchorView = txtCustomSearch
        dropDownAirport.bottomOffset = CGPoint(x: 0, y: txtCustomSearch.bounds.height)
        dropDownAirport.backgroundColor = .white
        dropDownAirport.selectionBackgroundColor = .purply
        dropDownAirport.textColor = .black
        dropDownAirport.textFont = UIFont(name: "Poppins-Medium", size: 13.0) ?? .systemFont(ofSize: 13.0)

        dropDownAirport.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedIndex = index
            self.txtCustomSearch.text = item
        }
    }
}

extension ChooseAddressVC: CustomNavigationViewDelegate, AlertProtocol {
    func view(_ view: CustomNavigationView, didPressRight button: UIButton) {
        if txtCustomSearch.text != "" {
            switch isfrom {
            case .flight:
                delegate?.setFlight(airpotName: self.viewModel.tableDataSource.listArray2[selectedIndex].AirportName ??   "" , cityName: self.viewModel.tableDataSource.listArray2[selectedIndex].AirportCode ?? "", from: self.viewModel.locationType)
                break
            case .hotel:
                delegateHotel?.setHotel(cityName: self.viewModel.tableDataSource.listArray2[selectedIndex].City ?? "")
                break
            default:
                break
            }

            self.navigationController?.popViewController(animated: true)
        }else {
            self.showAlertWithText("Please select one of the airport", buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
                //self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
