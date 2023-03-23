//
//  SearchResultVC.swift
//  Pneuma
//
//  Created by iTechnolabs on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import Alamofire

class SearchResultVC: UIViewController {
    
    //MARK:- IBOUTLET
    @IBOutlet weak var lblRoomName: UILabel!
    @IBOutlet weak var lblRoomType: UILabel!
    @IBOutlet weak var constraintBottomRoomType: NSLayoutConstraint!
    @IBOutlet weak var lblRoomAmenities: UILabel!
    @IBOutlet weak var lblRoomPrice: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var viewStack1: UIStackView!
    @IBOutlet weak var lblRoomFacilities1: UILabel!
    @IBOutlet weak var viewStack2: UIStackView!
    @IBOutlet weak var lblRoomFacilities2: UILabel!
    @IBOutlet weak var viewStack3: UIStackView!
    @IBOutlet weak var lblRoomFacilities3: UILabel!
    @IBOutlet weak var photosTableview: UITableView!
    @IBOutlet weak var constraintTableviewPhotosHeight: NSLayoutConstraint!
    
    // MARK: - VARIABLES
    let cellIdentifier = "ViewPhotosTableCell"
    let viewModel = BookHotelVM()
    var hotelData : HotelSearchData?
    var room : Room?

    var arrImages = [String]()
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.setData()
    }

    func setData() {
        lblRoomName.text = room?.roomType
        lblRoomType.text = ""
        lblRoomAmenities.text = ""
        lblRoomPrice.text = "\(room?.roomRate ?? 0.0)"
        lblCurrency.text = room?.currencyCode
        if lblRoomType.text != "" && lblRoomAmenities.text != "" {
            constraintBottomRoomType.constant = 20
        }else {
            constraintBottomRoomType.constant = 0
        }
        viewStack1.isHidden = true
        viewStack2.isHidden = true
        viewStack3.isHidden = true
        arrImages = hotelData?.hotelImages ?? [String]()
        constraintTableviewPhotosHeight.constant = CGFloat(200 * arrImages.count)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func registerNib() {
        let nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        self.photosTableview.register(nib, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    private func gotoNextStep() {
        
        AppCache.shared.selectedBookingOptions.completeCurrentStep()
        if let vc = AppCache.shared.selectedBookingOptions.nextController() {
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = UIStoryboard.loadBookingCompleteVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - IBACTIONS
    @IBAction func reserveButtonAction(_ sender: UIButton) {
        setDataToVM()
        if let message = self.viewModel.validation() {
           self.showAlertWithText(message)
        }else{
           self.bookHotelInternal()
            //self.bookHotel()
        }
        
    }
    
    private func setDataToVM() {
        self.viewModel.requestModel.user_id = "\(AppCache.shared.currentUser?.id ?? 1)"
        self.viewModel.requestModel.name = hotelData?.hotelName
        if let address = hotelData?.hotelAddress {
            if address.contains(",") {
                let subAddress = address.components(separatedBy: ",")
                self.viewModel.requestModel.address = subAddress[0]
            }else {
                self.viewModel.requestModel.address = address
            }
        }
        self.viewModel.requestModel.room_type = hotelData?.rooms?[0].roomType ?? ""
        self.viewModel.requestModel.price = "\(hotelData?.rooms?[0].roomRate ?? 0.0)"
        //self.viewModel.requestModel.image = hotelData?.hotelImages?[0] ?? ""
        self.viewModel.requestModel.features = hotelData?.amenities
        self.viewModel.requestModel.check_in = Date().dayAfter.getStringFullDate(format: .fullDate, timeZone: .current)
        self.viewModel.requestModel.check_out = Date().dayAfter.dayAfter.getStringFullDate(format: .fullDate, timeZone: .current)
    }

    func bookHotelInternal() {
        CustomLoader.shared.show()
        let newHeaders: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")",
            "Content-Type": "multipart/form-data"
        ]

        let param = self.viewModel.requestModel

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data("\(param.user_id ?? "")".utf8), withName: "user_id")
            multipartFormData.append(Data("\(param.name ?? "")".utf8), withName: "name")
            multipartFormData.append(Data("\(param.address ?? "")".utf8), withName: "address")
            multipartFormData.append(Data("\(param.room_type ?? "")".utf8), withName: "room_type")
            multipartFormData.append(Data("\(param.price ?? "")".utf8), withName: "price")
            //multipartFormData.append(Data("\(param.image ?? "")".utf8), withName: "image")
            let imgView = UIImageView()
            if let imgStr = self.hotelData?.hotelImages?[0] {
                imgView.kf.setImage(with: URL(string: imgStr))
                if let data = imgView.image?.pngData(){
                    multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
                }
            }
            if let arrFeatures = param.features {
          	      for (i,e) in arrFeatures.enumerated() {
                    multipartFormData.append(Data(e.utf8), withName: "features[\(i)]")
                }
            }
            multipartFormData.append(Data("\(param.check_in ?? "")".utf8), withName: "check_in")
            multipartFormData.append(Data("\(param.check_out ?? "")".utf8), withName: "check_out")
        },to: "http://ec2-3-145-217-61.us-east-2.compute.amazonaws.com/api/hotel/book", method: .post, headers: newHeaders).responseJSON { response in
            print(response)
            switch response.result {
            case .success(let json):
                CustomLoader.shared.hide()
                print(json)
                let vc = UIStoryboard.loadBookingCompleteVC()
                vc.hotelData = self.hotelData
                self.navigationController?.pushViewController(vc, animated: true)
//                if let dict = json as? [String:Any] {
//                    if let message = dict["message"] as? String {
//                        self.showAlertWithText(message)
//                        let vc = UIStoryboard.loadBookingCompleteVC()
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                }
            case .failure(let error):
                print(error)
                CustomLoader.shared.hide()
                self.showAlertWithText(error.localizedDescription)
            }
        }
    }
}
extension SearchResultVC: AlertProtocol {
     fileprivate func bookHotel() {
           CustomLoader.shared.show()
           self.viewModel.bookHotel { [weak self] (result) in
               CustomLoader.shared.hide()
               guard let `self` = self else {
                   return
               }
               switch result {
               case .success(_):
                   //Handle UI or navigation
                   self.showAlertWithText(self.viewModel.responseModel?.message ?? "", buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
                       self.gotoNextStep()
                   }
                   return
               case .failure(let error):
                   self.showAlertWithText(error.message)
               }
           }
       }
}
