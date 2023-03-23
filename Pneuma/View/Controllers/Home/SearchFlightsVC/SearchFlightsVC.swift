//
//  SearchFlightsVC.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll
import DropDown

class SearchFlightsVC: BaseVC {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigation: CustomNavigationView!
    @IBOutlet weak var btnDropDown: UIButton!
    
    // MARK: - VARIABLES
  //  private let cellIdentifier = "SearchFlightsTableCell"
    let viewModel = SearchFlightsVM()
    var navTitle : String? = ""
    var origin : String? = ""
    var destination : String? = ""
    var selectedClass : String?
    var numberOfAdults : Int?
    var numberOfChildren : Int?
    var numberOfInfants : Int?
    var age : [Any]?
    var totalPassangers: Int = 0
    var max_stops : Int?
    var sort : String?
    var max_duration : Int?
    var departureDate : Date? = Date()
    var returnDate : Date? = Date()
   
    fileprivate var dropDownAirport = DropDown()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.fullDate.rawValue
        return formatter
    }()
    
    // MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalPassangers = self.numberOfAdults! + self.numberOfChildren! //+ self.numberOfInfants!
        self.navigation.title = navTitle
        self.navigation.delegate = self
        max_stops = 0
        max_duration = 20
        viewModel.objSearchFlightsTableDataSourceModel.offset = 1
        viewModel.objSearchFlightsTableDataSourceModel.limit = 10
        self.setupTableView()
        viewModel.tableDataSource.isReturn =  false
        viewModel.tableDataSource.isRoundTrip =  returnDate != nil ? true : false
       // btnMenu.setTitle("Departing Flights", for: .normal)
    }
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.objSearchFlightsTableDataSourceModel.selectSection = -1
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - PRIVATE FUNCTIONS
    private func setupTableView() {
        self.registerNib()
        self.tableView.dataSource = self.viewModel.tableDataSource
        self.tableView.estimatedRowHeight = 500
        tableView.addInfiniteScroll { (tableView) -> Void in
            // update table view
           
                self.viewModel.objSearchFlightsTableDataSourceModel.limit += 1
                self.viewModel.objSearchFlightsTableDataSourceModel.offset = 10
                self.handleApiData()
          
            // finish infinite scroll animation
            tableView.finishInfiniteScroll()
        }
        //configureTapMeButtonMenu()
        btnDropDown.setTitle("Departing Flights", for: .normal)
        handleApiData()
       
    }
    @IBAction func actionDropDown( _ sender : UIButton){
        if returnDate != nil {
            DispatchQueue.main.async {
                self.setupDropDown()
            }
        }
    }
    func setupDropDown() {

        //<-------------------FOR AIRPORT------------------->
        dropDownAirport.anchorView = btnDropDown
        dropDownAirport.bottomOffset = CGPoint(x: 0, y: btnDropDown.bounds.height)
        dropDownAirport.backgroundColor = .white
        dropDownAirport.selectionBackgroundColor = .purply
        dropDownAirport.textColor = .black
        dropDownAirport.textFont = UIFont(name: "Poppins-Medium", size: 13.0) ?? .systemFont(ofSize: 13.0)
        let flightType =  ["Departing Flights","Returning Flights"]
        dropDownAirport.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            if item == "Departing Flights" {
                btnDropDown.setTitle(item, for: .normal)
                self.viewModel.tableDataSource.isReturn =  false
            }
            if item == "Returning Flights" {
                btnDropDown.setTitle(item, for: .normal)
                self.viewModel.tableDataSource.isReturn =  true
              
            }
            self.tableView.reloadData()
            self.viewModel.objSearchFlightsTableDataSourceModel.offset = 1
            self.viewModel.objSearchFlightsTableDataSourceModel.limit = 10
            self.viewModel.objSearchFlightsTableDataSourceModel.selectSection = -1
            dropDownAirport.hide()
        }
        dropDownAirport.dataSource = flightType
        dropDownAirport.show()
    }
   

    private func registerNib() {
      
        let nibHeader = UINib(nibName:"SearchFlightsHeaderTVC", bundle: nil)
        self.tableView.register(nibHeader, forCellReuseIdentifier: "SearchFlightsHeaderTVC")
        let nibfeader = UINib(nibName:"SearchFlightsDetailsTVC", bundle: nil)
        self.tableView.register(nibfeader, forCellReuseIdentifier: "SearchFlightsDetailsTVC")
        
    }
    
    private func showFilters() {
        let vc = UIStoryboard.loadPassengerTicketFilterVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.isSelectedData = { maxLimit , maxDuration,sort in
            self.max_stops =  maxLimit
            self.max_duration =  maxDuration
            self.sort = sort
            self.viewModel.objSearchFlightsTableDataSourceModel.offset = 1
            self.viewModel.objSearchFlightsTableDataSourceModel.limit = 10
            self.viewModel.objSearchFlightsTableDataSourceModel.selectSection = -1
            self.setupTableView()
        }
        vc.max_duration = max_duration!
        vc.maxLimit = max_stops!
        vc.sort = sort ?? ""
        self.present(vc, animated: true, completion: nil)
    }
    func handleApiData(){
        CustomLoader.shared.show()
        var strReturnDate: String? = nil
        if returnDate != nil {
            strReturnDate = self.dateFormatter.string(from: returnDate!)
        }
        let maxDuration =  /max_duration * 60
        let model = SearchFlightModelParam(origin: origin, destination: destination, departureDate: self.dateFormatter.string(from: departureDate!), returnDate: strReturnDate, cabin: selectedClass, adults: numberOfAdults, children: numberOfChildren, children_age: age ?? [],max_stop: max_stops,max_duration: maxDuration,pagination: ["limit" : viewModel.objSearchFlightsTableDataSourceModel.limit,"offset" :viewModel.objSearchFlightsTableDataSourceModel.offset], sort_by: sort)
        print(model)
           self.viewModel.getFlightSearch(model) { [weak self] (result) in
            
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(_):
                //Handle UI or navigation
                self.tableView.dataSource = self.viewModel.tableDataSource
                self.tableView.reloadData()
                if /self.viewModel.tableDataSource.listArray2.count == 0 {
                    self.btnDropDown.isHidden = true
                    self.showErrorView(error: "No Flights Available. Please change dates and try again", scrollView: self.tableView, tapped: {
                        self.errorView.removeFromSuperview()
                        self.tableView.beginInfiniteScroll(true)//error.message
                    })
                }
              //  self.view.setNeedsLayout()
                return
            case .failure(let error):
                if /self.viewModel.tableDataSource.listArray2.count == 0 {
                    self.btnDropDown.isHidden = true
                    self.showErrorView(error: "No Flights Available. Please change dates and try again", scrollView: self.tableView, tapped: {
                        self.errorView.removeFromSuperview()
                        self.tableView.beginInfiniteScroll(true)//error.message
                    })
                }
                return
            }
        }
    }
}

// MARK: - NAVIGATION VIEW DELEGATE
extension SearchFlightsVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressRight button: UIButton) {
        self.showFilters()
    }
}
