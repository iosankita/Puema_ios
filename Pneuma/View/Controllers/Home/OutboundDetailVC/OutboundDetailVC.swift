//
//  OutboundDetailVC.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
var Flight = "Flight"
class OutboundDetailVC: UIViewController, AlertProtocol {

    // MARK: - IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customNavigationView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var dottedLineView: UIView!
    @IBOutlet weak var fromAddressLabel: UILabel!
    @IBOutlet weak var toAddressLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalTimeAndDateContainerView: UIView!
    @IBOutlet weak var viewCollectionConatiner: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewPageControl: UIView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: - VARIABLES
    private let cellIdentifier = "OutboundDetailTableCell"
    let viewModel = OutboundDetailVM()
    var objFlightSearchResponseData : FlightSearchResponseData?
   // var objFlightData : SearchResultModel?
    var numberOfItemsInCollection : Int? = 0
    var numberOfBookSeat : Int? = 0
    var numberOfAdults : Int? = 0
    var numberOfChildren : Int? = 0
    var numberOfInfants : Int? = 0
    var id : String? = ""
    var dataSource : String? = ""
    var code : String? = ""
    var locationCode : String? = ""
    var locArray = [String]()
    var objSearchFlightsVM = SearchFlightsVM()
    // MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        handleData()
        self.setData(objSelectedFlightData?.first?.AirItinerary?.first)
        self.collectionView.reloadData()
        locationCode =  self.appendLocationNameTitle(arr: objSelectedFlightData?.first?.AirItinerary?.first?.FlightSegment ?? [])
        code =  self.appendParamTitle(arr: objSelectedFlightData?.first?.AirItinerary?.first?.FlightSegment ?? [])
        getSearchName(locationCode)
        getAriName()
    }
        
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.drawDottedLine()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.customizeUI()
    }
    
    func getAriName(){
                if code != "" {
                    objSearchFlightsVM.getAirlineDetails(code: code ?? ""){ result in
                        switch result {
                        case .success(_):
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                            break
                        case .failure(let error):
                            print(error)
                            break
                        }
                    }
                }
    }
    // MARK: - IBACTIONS
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookButtonAction(_ sender: UIButton) {
        if numberOfBookSeat ?? 0 > objFlightSearchResponseData?.numberOfBookableSeats ?? 0  {
            self.showAlertWithText("Flight does not have this much seats available")
            return
        }
        let vc = UIStoryboard.loadPassengerInfoVC()
        vc.numberOfBookSeat = numberOfBookSeat
        vc.numberOfAdults = numberOfAdults
        vc.numberOfChildren = numberOfChildren
        vc.numberOfInfants = numberOfInfants
        vc.objFlightSearchResponseData = objFlightSearchResponseData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func shareButtonAction(_ sender: UIButton) {
        self.view.createPdfFromView(saveToDocumentsWithFileName: "mybookinginfo")
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func customizeUI() {
        self.customNavigationView.roundBottomCorners()
    }
  
    private func handleData(){
       
        self.tableView.isHidden = true
        self.collectionView.isHidden = false
        self.setupCollectionView()
        self.collectionView.reloadData()
       
    }
    private func drawDottedLine() {
        let x = self.dottedLineView.center.x
        self.dottedLineView.drawDottedLine(start: CGPoint(x: x, y: 0), end: CGPoint(x: x, y: self.dottedLineView.frame.maxY), color: .lightBlueGrey40Opacity)
        
        self.totalTimeAndDateContainerView.addLineDashedStroke(radius: 4, color: UIColor.pinkishPurple.cgColor, width: 1)
    }

    private func setData( _ objAirItinerary : AirItineraryModel?) {
      
            let model =  objAirItinerary
            let originName =  objSearchFlightsVM.tableDataSource.arrSearchCityData.filter({ $0.AirportCode == model?.FlightSegment?.first?.DepartureDetails?.LocationCode ?? "" }).first
            
            let arrivalName =  objSearchFlightsVM.tableDataSource.arrSearchCityData.filter({ $0.AirportCode == model?.FlightSegment?.last?.ArrivalDetails?.LocationCode ?? "" }).first
            
            self.fromAddressLabel.text = "\(/model?.FlightSegment?.first?.DepartureDetails?.LocationCode) - \(originName?.AirportName ?? "")"
            self.toAddressLabel.text = "\(/model?.FlightSegment?.last?.ArrivalDetails?.LocationCode)- \(arrivalName?.AirportName ?? "")"
        var interval: TimeInterval =  TimeInterval(/model?.ElapsedTime)
        let time =   interval.stringFromDurationInterval()
        ///model?.FlightSegment?.first?.DepartureDateTime?.getDate()?.offsetFrom(model?.FlightSegment?.last?.ArrivalDateTime?.getDate())
             let stop = /model?.FlightSegment?.count
            self.totalTimeLabel.text = time + ", " + "\(stop - 1)" + " Stop"
            
            self.dateLabel.text = model?.FlightSegment?.first?.DepartureDateTime?.getDate()?.getStringFullDate(format: .FlightTime, timeZone: .current)
            
        self.numberOfItemsInCollection = /objSelectedFlightData?.count
                self.pageControl.numberOfPages = /objSelectedFlightData?.count
            collectionView.reloadData()
        
    }
    
   

    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let collNib = UINib(nibName: "InOutBoundCell", bundle: nil)
        self.collectionView.register(collNib, forCellWithReuseIdentifier: "InOutBoundCell")
    }

}

extension OutboundDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInCollection ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell : InOutBoundCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InOutBoundCell", for: indexPath) as? InOutBoundCell else {
            return UICollectionViewCell()
        }
       
            cell.objModel.tableDataSource.airlineModel = objSearchFlightsVM.tableDataSource.arrAirlineInfoModel ?? []
            cell.objModel.tableDataSource.arrSearchCityData = objSearchFlightsVM.tableDataSource.arrSearchCityData
            cell.title = Flight
            if indexPath.row == 0 {
                
                cell.setUpData( objSelectedFlightData?.first?.AirItinerary?.first)
            }
            if indexPath.row == 1 {
               
                cell.setUpData2( objSelectedFlightData?.last?.AirItinerary?.last)
            }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.width, height:self.collectionView.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension OutboundDetailVC: UIScrollViewDelegate {
    //MARK:- UIScrollView Delegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UICollectionView.self) {
            if numberOfItemsInCollection == 2 {
               
                if(scrollView.contentOffset.x >= (self.collectionView.contentSize.width - self.collectionView.bounds.size.width)) {
                    self.lblTitle.text = "Inbound Details"
                    locationCode =  self.appendLocationNameTitle(arr: objSelectedFlightData?.last?.AirItinerary?.last?.FlightSegment ?? [])
                    code =  self.appendParamTitle(arr: objSelectedFlightData?.last?.AirItinerary?.last?.FlightSegment ?? [])
                  
                    self.setData(objSelectedFlightData?.last?.AirItinerary?.last)
                    self.pageControl.currentPage = 1
                }else if(scrollView.contentOffset.x <= (self.collectionView.contentSize.width - self.collectionView.bounds.size.width)) {
                    self.lblTitle.text = "Outbound Details"
                    locationCode =  self.appendLocationNameTitle(arr: objSelectedFlightData?.first?.AirItinerary?.first?.FlightSegment ?? [])
                    code =  self.appendParamTitle(arr: objSelectedFlightData?.first?.AirItinerary?.first?.FlightSegment ?? [])
                  
                    self.setData(objSelectedFlightData?.first?.AirItinerary?.first)
                    self.pageControl.currentPage = 0
                }
            }else {
                locationCode =  self.appendLocationNameTitle(arr: objSelectedFlightData?.first?.AirItinerary?.first?.FlightSegment ?? [])
                code =  self.appendParamTitle(arr: objSelectedFlightData?.first?.AirItinerary?.first?.FlightSegment ?? [])
                self.setData(objSelectedFlightData?.first?.AirItinerary?.first)
                self.pageControl.currentPage = 0
            }
        }
    }
    func getSearchName( _ name : String?){
        objSearchFlightsVM.getSearchAirportName(search: name ?? ""){ result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                   // self.setData(self.objFlightData?.AirItinerary?.first)
                    self.setData(objSelectedFlightData?.first?.AirItinerary?.first)
                    self.collectionView.reloadData()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
