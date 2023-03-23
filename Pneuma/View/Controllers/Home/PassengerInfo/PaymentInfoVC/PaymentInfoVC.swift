//
//  PaymentInfoVC.swift
//  Pneuma
//
//  Created by Jatin on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import Stripe
import PassKit
import Alamofire

protocol PaymentInfoVCDelegate: class {
    func vc(_ vc: PaymentInfoVC, didPressAddPayment button: UIButton)
    func vc(_ vc: PaymentInfoVC, didPressComplete button: UIButton)
}

class PaymentInfoVC: UIViewController, AlertProtocol {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var viewFareSummary: UIView!
    @IBOutlet weak var lblBaseFarePrice: UILabel!
    @IBOutlet weak var lblTaxesPrice: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!

    // MARK: - VARIABLES
    weak var delegate: PaymentInfoVCDelegate?
    var viewModel = PaymentInfoVM()
   // var paymentSheet: PaymentSheet?

    var createIntentModel: PaymentIntentModel?
    var customerModel: CustomerModel?
    var createEphemeralKeyModel: EphemeralModel?
    var createOrderResponse: CreateOrderResponse?
    var priceFareResponse: PriceFareResponseModel?

    var objFlightSearchResponseData : FlightSearchResponseData?
    var numberOfBookSeat : Int? = 1
    var totalPricing : Float? = 1.0
    var finalPricing : Double? = 0
    var numberOfAdults : Int? = 0
    var numberOfChildren : Int? = 0
    var numberOfInfants : Int? = 0
    var totalPassangers : Int? = 0

    var arrPassengerList: [PassangerDict]!
    
    // MARK: - VARIABLES
    private var paymentMethodViewArray = [PaymentMethodView]()

    let applePayButton: PKPaymentButton = PKPaymentButton(paymentButtonType: .plain, paymentButtonStyle: .black)
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setData()
        self.callAPI()
        self.addPaymentMethod()

        applePayButton.isHidden = !StripeAPI.deviceSupportsApplePay()
        applePayButton.addTarget(self, action: #selector(handleApplePayButtonTapped), for: .touchUpInside)
    }

    private func setData() {
        let amount = Float(objFlightSearchResponseData?.priceTotal ?? "") ?? 0.0
        totalPricing = amount * Float(numberOfBookSeat!) * 100
        finalPricing = Double(totalPricing ?? 0.0)
        amountLabel.text = "\(amount * Float(numberOfBookSeat!)) \(objFlightSearchResponseData?.priceCurrency ?? "USD")"
    }

    private func callAPI() {
        CustomLoader.shared.show()
        self.viewModel.createCustomer { [weak self] (result) in
            DispatchQueue.main.async {
                guard let `self` = self else {
                    return
                }
                switch result {
                case .success(let response):
                    //Handle UI or navigation
                    print(response)
                    guard let data = response.resultData as? Data else {
                        return
                    }
                    self.customerModel = JSONDecoder().convertDataToModel(data)
                    print(self.customerModel)
                    self.viewModel.createEphemeralKey(params: ["customer":self.customerModel?.id ?? ""]){ [weak self] (result) in
                        DispatchQueue.main.async {
                            guard let `self` = self else {
                                return
                            }
                            switch result {
                            case .success(let response):
                                print("Response",response)
                                guard let data = response.resultData as? Data else {
                                    return
                                }
                                self.createEphemeralKeyModel = JSONDecoder().convertDataToModel(data)
                                if response.statusCode == 200 {
                                    self.viewModel.createPaymentIndent(params: ["currency":self.objFlightSearchResponseData?.priceCurrency ?? "USD","amount":"\(Int(self.finalPricing ?? 0.0))","customer":self.customerModel?.id ?? "", "automatic_payment_methods[enabled]":"true"]) { (result) in
                                        DispatchQueue.main.async {
                                            switch result {
                                            case .success(let response):
                                                print("Response",response)
                                                guard let data = response.resultData as? Data else {
                                                    return
                                                }
                                                self.createIntentModel = JSONDecoder().convertDataToModel(data)
                                                self.configureStripePaymentSheet(intent: self.createIntentModel, emphral: self.createEphemeralKeyModel)
                                            case .failure(let error):
                                                CustomLoader.shared.hide()
                                                print("Error",error)
                                            }
                                        }
                                    }
                                }
                            case .failure(let error):
                                CustomLoader.shared.hide()
                                print("Error",error)
                            }
                        }
                    }
                    return
                case .failure(let error):
                    print(error)
                    CustomLoader.shared.hide()
                    return
                }
            }
        }
    }

    private func fareSummary() {
        CustomLoader.shared.show()
        self.viewModel.createFareSummary(params: ["flight_search":objFlightSearchResponseData?.allData?.toJSONString() ?? ""]) { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                //Handle UI or navigation
                print(response)
                //DispatchQueue.main.async {
                guard let data = response.resultData as? Data else {
                    return
                }
                self.priceFareResponse = JSONDecoder().convertDataToModel(data)
                let priceData = self.priceFareResponse?.data?.flightOffers?[0].travelerPricings?[0].price
                print("Price Fare ::",self.priceFareResponse)
                self.lblBaseFarePrice.text = priceData?.base ?? "0"
                let tax = Float(priceData?.total ?? "0.0")! - Float(priceData?.base ?? "0.0")!
                self.lblTaxesPrice.text = "\(tax)"
                self.lblTotalPrice.text = priceData?.total ?? "0"
                //}
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }

    private func configureStripePaymentSheet(intent:PaymentIntentModel?, emphral:EphemeralModel?) {
        STPAPIClient.shared.publishableKey = AppConstants.Urls.stripePublishableKey
        // MARK: Create a PaymentSheet instance
//        var configuration = PaymentSheet.Configuration()
//        configuration.applePay = .init(
//          merchantId: "merchant.com.tisicorporation.pneuma",
//          merchantCountryCode: "US"
//        )
//        configuration.primaryButtonColor = .purply
//        configuration.merchantDisplayName = "TISI"
//        configuration.customer = .init(id: emphral?.associatedObjects?[0].id ?? "", ephemeralKeySecret: emphral?.secret ?? "")
//        // Set `allowsDelayedPaymentMethods` to true if your business can handle payment
//        // methods that complete payment after a delay, like SEPA Debit and Sofort.
//        configuration.returnURL = "Pneuma://stripe-redirect"
//        configuration.allowsDelayedPaymentMethods = true
//        self.paymentSheet = PaymentSheet(paymentIntentClientSecret: intent?.clientSecret ?? "", configuration: configuration)
        CustomLoader.shared.hide()
        self.fareSummary()
    }
    
    // MARK: - IBACTIONS
    @IBAction func addMethodButtonAction(_ sender: UIButton) {
        self.delegate?.vc(self, didPressAddPayment: sender)
    }
    
    @IBAction func completeButtonAction(_ sender: UIButton) {
//        setDataToVM()
//        if let message = self.viewModel.validation() {
//           self.showAlertWithText(message)
//        }else{
//           self.bookFlight(sender)
//        }
//        paymentSheet?.present(from: self) { paymentResult in
//            // MARK: Handle the payment result
//            switch paymentResult {
//            case .completed:
//                //self.showAlertWithText("Flight ticket book succesfully.")
//                self.createOrder()
//            case .canceled:
//                print("Canceled!")
//                self.showAlertWithText("Something went wrong!!!")
//            case .failed(let error):
//                print("Payment failed: \(error)")
//                //self.showAlertWithText(error)
//            }
//          }
    }

    @IBAction func btnPayWithCrypto(_ sender: Any) {
        self.callAPI(name: "Jatin", description: "Flight Book", price: "\(finalPricing!/100)")
    }

    @objc func handleApplePayButtonTapped() {
        let merchantIdentifier = "merchant.com.tisicorporation.pneuma"
        let paymentRequest = StripeAPI.paymentRequest(withMerchantIdentifier: merchantIdentifier, country: "US", currency: "USD")

        // Configure the line items on the payment request
        paymentRequest.paymentSummaryItems = [
            // The final line should represent your company;
            // it'll be prepended with the word "Pay" (that is, "Pay iHats, Inc $50")
            PKPaymentSummaryItem(label: "TISI", amount: finalPricing as! NSDecimalNumber),
        ]

        if let applePayContext = STPApplePayContext(paymentRequest: paymentRequest, delegate: self) {
            // Present Apple Pay payment sheet
            applePayContext.presentApplePay()
        } else {
            // There is a problem with your Apple Pay configuration
        }
    }

    func callAPI(name:String, description:String, price: String) {

        guard let serviceUrl = URL(string: "https://api.commerce.coinbase.com/charges") else { return }
        let params : [String:Any] = ["name": "\(name)","description": "Mastering the Transition to the Information Age","local_price": ["amount": "\(price)","currency": "USD"],"pricing_type": "fixed_price","metadata": ["user_id":"1","user_name": "\(name)"],"redirect_url": "https://charge/completed/page","cancel_url": "https://charge/canceled/page"]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("ea54dfcf-dc45-4b84-a4cd-ea74b79a3a15", forHTTPHeaderField: "X-CC-Api-Key")
        request.setValue("2018-03-22", forHTTPHeaderField: "X-CC-Version")

        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return
        }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let response = response {
                    print(response)
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Full HTTP Response: \(httpResponse)")
                        print("StatusCode : \(httpResponse.statusCode)")
                        print("StatusMessage : \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
                        DispatchQueue.main.async {
                            if httpResponse.statusCode == 201 || httpResponse.statusCode == 200 {

                            }else {

                            }
                        }
                    }
                }
                if let data = data {
                    let chargeResponse = try? JSONDecoder().decode(ChargeResponse.self, from: data)
                    print(chargeResponse)
                    print(chargeResponse?.data?.id)
                    print(chargeResponse?.data?.hostedurl)
                    do {
                        // Create JSON Encoder
                        let encoder = JSONEncoder()
                        UserDefaults.standard.set(Date(), forKey: "chargeDate")
                        // Encode carSubData
                        let dataChargeResponse = try encoder.encode(chargeResponse ?? ChargeResponse())
                        UserDefaults.standard.set(dataChargeResponse, forKey: "chargeResponse")
                        
                        let dataPassangerDict = try encoder.encode(self.arrPassengerList ?? [PassangerDict]())
                        UserDefaults.standard.set(dataPassangerDict, forKey: "passengerList")
                        UserDefaults.standard.set(chargeResponse?.data?.id, forKey: "chargeId")
                        UserDefaults.standard.synchronize()
                        
                        let vc = UIStoryboard.loadCryptoPaymentVC()
                        vc.chargeID = chargeResponse?.data?.id
                        vc.hostedUrl = chargeResponse?.data?.hostedurl ?? ""
                        self.navigationController?.pushViewController(vc, animated: true)
                    } catch {
                        print("Unable to Encode Note (\(error))")
                    }
                }
            }
        }.resume()
    }

    func createOrder() {
        var param : CreateOrderParam = CreateOrderParam(passengers: "", email_address: "", country_calling_code: "", mobile_number: "", flight_search: "", first_name: "", last_name: "", date_of_birth: "", gender: "")
        param.passengers = "\(arrPassengerList.count)"
        if arrPassengerList.count == 1 {
            param.mobile_number = arrPassengerList[0].mobileNumber
            param.country_calling_code = arrPassengerList[0].countryCode.replacingOccurrences(of: "+", with: "")
            param.email_address = arrPassengerList[0].email
            param.flight_search = objFlightSearchResponseData?.allData?.toJSONString()
            param.first_name = arrPassengerList[0].first_name
            param.last_name = arrPassengerList[0].last_name
            param.date_of_birth = arrPassengerList[0].date_of_birth
            param.gender = arrPassengerList[0].gender
            param.first_name1 = ""
            param.last_name1 = ""
            param.date_of_birth1 = ""
            param.gender1 = ""
            param.first_name2 = ""
            param.last_name2 = ""
            param.date_of_birth2 = ""
            param.gender2 = ""
            param.first_name3 = ""
            param.last_name3 = ""
            param.date_of_birth3 = ""
            param.gender3 = ""
            param.first_name4 = ""
            param.last_name4 = ""
            param.date_of_birth4 = ""
            param.gender4 = ""
        }else if arrPassengerList.count == 2 {
            param.mobile_number = arrPassengerList[0].mobileNumber
            param.country_calling_code = arrPassengerList[0].mobileNumber
            param.email_address = arrPassengerList[0].email
            param.flight_search = objFlightSearchResponseData?.allData?.toJSONString()
            param.first_name = arrPassengerList[0].first_name
            param.last_name = arrPassengerList[0].last_name
            param.date_of_birth = arrPassengerList[0].date_of_birth
            param.gender = arrPassengerList[0].gender
            param.first_name1 = arrPassengerList[1].first_name
            param.last_name1 = arrPassengerList[1].last_name
            param.date_of_birth1 = arrPassengerList[1].date_of_birth
            param.gender1 = arrPassengerList[1].gender
            param.first_name2 = ""
            param.last_name2 = ""
            param.date_of_birth2 = ""
            param.gender2 = ""
            param.first_name3 = ""
            param.last_name3 = ""
            param.date_of_birth3 = ""
            param.gender3 = ""
            param.first_name4 = ""
            param.last_name4 = ""
            param.date_of_birth4 = ""
            param.gender4 = ""
        }else if arrPassengerList.count == 3 {
            param.mobile_number = arrPassengerList[0].mobileNumber
            param.country_calling_code = arrPassengerList[0].mobileNumber
            param.email_address = arrPassengerList[0].email
            param.flight_search = objFlightSearchResponseData?.allData?.toJSONString()
            param.first_name = arrPassengerList[0].first_name
            param.last_name = arrPassengerList[0].last_name
            param.date_of_birth = arrPassengerList[0].date_of_birth
            param.gender = arrPassengerList[0].gender
            param.first_name1 = arrPassengerList[1].first_name
            param.last_name1 = arrPassengerList[1].last_name
            param.date_of_birth1 = arrPassengerList[1].date_of_birth
            param.gender1 = arrPassengerList[1].gender
            param.first_name2 = arrPassengerList[2].first_name
            param.last_name2 = arrPassengerList[2].last_name
            param.date_of_birth2 = arrPassengerList[2].date_of_birth
            param.gender2 = arrPassengerList[2].gender
            param.first_name3 = ""
            param.last_name3 = ""
            param.date_of_birth3 = ""
            param.gender3 = ""
            param.first_name4 = ""
            param.last_name4 = ""
            param.date_of_birth4 = ""
            param.gender4 = ""
        }else if arrPassengerList.count == 4 {
            param.mobile_number = arrPassengerList[0].mobileNumber
            param.country_calling_code = arrPassengerList[0].mobileNumber
            param.email_address = arrPassengerList[0].email
            param.flight_search = objFlightSearchResponseData?.allData?.toJSONString()
            param.first_name = arrPassengerList[0].first_name
            param.last_name = arrPassengerList[0].last_name
            param.date_of_birth = arrPassengerList[0].date_of_birth
            param.gender = arrPassengerList[0].gender
            param.first_name1 = arrPassengerList[1].first_name
            param.last_name1 = arrPassengerList[1].last_name
            param.date_of_birth1 = arrPassengerList[1].date_of_birth
            param.gender1 = arrPassengerList[1].gender
            param.first_name2 = arrPassengerList[2].first_name
            param.last_name2 = arrPassengerList[2].last_name
            param.date_of_birth2 = arrPassengerList[2].date_of_birth
            param.gender2 = arrPassengerList[2].gender
            param.first_name3 = arrPassengerList[3].first_name
            param.last_name3 = arrPassengerList[3].last_name
            param.date_of_birth3 = arrPassengerList[3].date_of_birth
            param.gender3 = arrPassengerList[3].gender
            param.first_name4 = ""
            param.last_name4 = ""
            param.date_of_birth4 = ""
            param.gender4 = ""
        }else if arrPassengerList.count == 5 {
            param.mobile_number = arrPassengerList[0].mobileNumber
            param.country_calling_code = arrPassengerList[0].mobileNumber
            param.email_address = arrPassengerList[0].email
            param.flight_search = objFlightSearchResponseData?.allData?.toJSONString()
            param.first_name = arrPassengerList[0].first_name
            param.last_name = arrPassengerList[0].last_name
            param.date_of_birth = arrPassengerList[0].date_of_birth
            param.gender = arrPassengerList[0].gender
            param.first_name1 = arrPassengerList[1].first_name
            param.last_name1 = arrPassengerList[1].last_name
            param.date_of_birth1 = arrPassengerList[1].date_of_birth
            param.gender1 = arrPassengerList[1].gender
            param.first_name2 = arrPassengerList[2].first_name
            param.last_name2 = arrPassengerList[2].last_name
            param.date_of_birth2 = arrPassengerList[2].date_of_birth
            param.gender2 = arrPassengerList[2].gender
            param.first_name3 = arrPassengerList[3].first_name
            param.last_name3 = arrPassengerList[3].last_name
            param.date_of_birth3 = arrPassengerList[3].date_of_birth
            param.gender3 = arrPassengerList[3].gender
            param.first_name4 = arrPassengerList[4].first_name
            param.last_name4 = arrPassengerList[4].last_name
            param.date_of_birth4 = arrPassengerList[4].date_of_birth
            param.gender4 = arrPassengerList[4].gender
        }
        guard let parameters = param.toJsonDict() else {return}
        CustomLoader.shared.show()
        self.viewModel.createOrder(params: parameters) { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    print(LocalizedStringEnum.somethingWentWrong.localized)
                    return
                }
                self.createOrderResponse = JSONDecoder().convertDataToModel(data)
//                if self.createOrderResponse?.data?.id != "" {
//                    let vc = UIStoryboard.loadFlightBookingCompletedVC()
//                    vc.createOrderResponse = self.createOrderResponse
//                    vc.objFlightSearchResponseData = self.objFlightSearchResponseData
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
                if self.createOrderResponse?.status == true {
                    self.createBookRequestModel(model: self.createOrderResponse!)
                }else {
                    self.showAlertWithText("Something went wrong!!!")
                }
                return
            case .failure(let error):
                self.showAlertWithText(error.message)
            }
        }
    }

    private func createBookRequestModel(model:CreateOrderResponse) {
        self.viewModel.requestModel.user_id = "\(AppCache.shared.currentUser?.id ?? 1)"
        self.viewModel.requestModel.origin = model.data?.flightOffers?.first?.itineraries?[0].segments?.first?.departure?.iataCode
        self.viewModel.requestModel.departure_date = model.data?.flightOffers?.first?.itineraries?[0].segments?.first?.departure?.at
        self.viewModel.requestModel.arrival_date = model.data?.flightOffers?.first?.itineraries?[0].segments?.first?.arrival?.at
        self.viewModel.requestModel.adults = "\(numberOfAdults ?? 0)"
        self.viewModel.requestModel.children = "\(numberOfChildren ?? 0)"
        self.viewModel.requestModel.infants = "\(numberOfInfants ?? 0)"
        self.viewModel.requestModel.cabin_class = model.data?.flightOffers?.first?.itineraries?[0].segments?.first?.co2Emission?[0].cabin
        self.viewModel.requestModel.payment_method_id = "1"
        self.viewModel.requestModel.total_payment = Float(model.data?.flightOffers?[0].price?.grandTotal ?? "0.0")
        self.viewModel.requestModel.destination = model.data?.flightOffers?.first?.itineraries?[0].segments?.first?.arrival?.iataCode
        self.viewModel.requestModel.estimated_time = objFlightSearchResponseData?.flightDict?.flightsList?.first?.duration
        self.viewModel.requestModel.flight_no = objFlightSearchResponseData?.flightDict?.flightsList?.first?.airlineNumber
        self.viewModel.requestModel.airline = objFlightSearchResponseData?.flightDict?.flightsList?.first?.airlineName
        self.viewModel.requestModel.airline_image = objFlightSearchResponseData?.flightDict?.flightsList?.first?.airline_logo
        self.viewModel.requestModel.coupon_code = ""
        self.viewModel.requestModel.discount = ""
        self.viewModel.requestModel.email = model.data?.travelers?.first?.contact?.emailAddress
        self.viewModel.requestModel.phone = model.data?.travelers?.first?.contact?.phones?.first?.number//"+\(model.data?.travelers?.first?.contact?.phones?.first?.countryCallingCode ?? "") \(model.data?.travelers?.first?.contact?.phones?.first?.number ?? "")"

        self.bookFlightInternal()
    }
    
    private func setDataToVM() {
//        self.viewModel.requestModel.user_id = AppCache.shared
//            .currentUser?.id ?? 1
//        self.viewModel.requestModel.origin = "Allama Iqbal International Airport"
//        self.viewModel.requestModel.departure_date = "2021-11-21 17:29:55"
//        self.viewModel.requestModel.arrival_date = "2021-11-22 17:29:55"
//        self.viewModel.requestModel.adults = 2
//        self.viewModel.requestModel.children = 1
//        self.viewModel.requestModel.infants = 1
//        self.viewModel.requestModel.cabin_class = "Economy"
//        self.viewModel.requestModel.payment_method_id = 1
//        self.viewModel.requestModel.total_payment = 1231
//        self.viewModel.requestModel.destination = "Islamabad Airport"
//        self.viewModel.requestModel.estimated_time = 24
//        self.viewModel.requestModel.flight_no = 452123
//        self.viewModel.requestModel.airline = "air blue"
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func addPaymentMethod() {
        for paymentMethod in self.viewModel.paymentMethods {
            let view: PaymentMethodView = .loadFromNib()
            view.delegate = self
            view.setupView(model: paymentMethod)
            view.heightAnchor.constraint(equalToConstant: 55).isActive = true
            //self.paymentMethodStackView.addArrangedSubview(view)
            self.paymentMethodViewArray.append(view)
        }
    }
}

// MARK: - PAYMENT METHOD VIEW DELEGATE
extension PaymentInfoVC: PaymentMethodViewDelegate {
    func view(_ view: PaymentMethodView, didPress button: UIButton, model: PaymentMethodDataModel?) {
        self.paymentMethodViewArray.forEach({$0.paymentButton.isSelected = false})
        button.isSelected = true
    }
}

extension PaymentInfoVC {
    fileprivate func bookFlight() {
        CustomLoader.shared.show()
        self.viewModel.bookFlight { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(_):
                //Handle UI or navigation
//                self.showAlertWithText(self.viewModel.responseModel?.message ?? "", buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
//                    self.delegate?.vc(self, didPressComplete: sender)
//                }
                self.showAlertWithText(self.viewModel.responseModel?.message ?? "")
                return
            case .failure(let error):
                self.showAlertWithText(error.message)
            }
        }
    }

    func bookFlightInternal() {
        CustomLoader.shared.show()
        let newHeaders: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")",
            "Content-Type": "multipart/form-data"
        ]

        let param = self.viewModel.requestModel

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data("\(param.user_id ?? "")".utf8), withName: "user_id")
            multipartFormData.append(Data("\(param.origin ?? "")".utf8), withName: "origin")
            multipartFormData.append(Data("\(param.departure_date ?? "")".utf8), withName: "departure_date")
            multipartFormData.append(Data("\(param.arrival_date ?? "")".utf8), withName: "arrival_date")
            multipartFormData.append(Data("\(param.adults ?? "")".utf8), withName: "adults")
            multipartFormData.append(Data("\(param.children ?? "")".utf8), withName: "children")
            multipartFormData.append(Data("\(param.infants ?? "")".utf8), withName: "infants")
            multipartFormData.append(Data("\(param.cabin_class ?? "")".utf8), withName: "cabin_class")
            multipartFormData.append(Data("\(param.payment_method_id ?? "")".utf8), withName: "payment_method_id")
            multipartFormData.append(Data("\(param.total_payment ?? 0.0)".utf8), withName: "total_payment")
            multipartFormData.append(Data("\(param.destination ?? "")".utf8), withName: "destination")
            multipartFormData.append(Data("\(param.estimated_time ?? "")".utf8), withName: "estimated_time")
            multipartFormData.append(Data("\(param.flight_no ?? "")".utf8), withName: "flight_no")
            multipartFormData.append(Data("\(param.airline ?? "")".utf8), withName: "airline")
            multipartFormData.append(Data("\(param.airline_image ?? "")".utf8), withName: "airline_image")
            multipartFormData.append(Data("\(param.email ?? "")".utf8), withName: "email")
            multipartFormData.append(Data("\(param.phone ?? "")".utf8), withName: "phone")
        },to: "http://ec2-3-145-217-61.us-east-2.compute.amazonaws.com/api/flight/book", method: .post, headers: newHeaders).responseJSON { response in
            print(response)
            switch response.result {
            case .success(let json):
                CustomLoader.shared.hide()
                print(json)
                let vc = UIStoryboard.loadFlightBookingCompletedVC()
                vc.createOrderResponse = self.createOrderResponse
                vc.numberOfAdults = self.numberOfAdults
                vc.numberOfChildren = self.numberOfChildren
                vc.numberOfInfants = self.numberOfInfants
                vc.totalPassangers = self.numberOfBookSeat ?? 0
                vc.objFlightSearchResponseData = self.objFlightSearchResponseData
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                print(error)
                CustomLoader.shared.hide()
                self.showAlertWithText(error.localizedDescription)
            }
        }
    }
}

extension PaymentInfoVC: STPApplePayContextDelegate {
    func applePayContext(_ context: STPApplePayContext, didCreatePaymentMethod paymentMethod: STPPaymentMethod, paymentInformation: PKPayment, completion: @escaping STPIntentClientSecretCompletionBlock) {
        CustomLoader.shared.show()
        self.viewModel.createCustomer { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                //Handle UI or navigation
                print(response)
                guard let data = response.resultData as? Data else {
                    return
                }
                self.customerModel = JSONDecoder().convertDataToModel(data)
                print(self.customerModel)
                self.viewModel.createEphemeralKey(params: ["customer":self.customerModel?.id ?? ""]){ [weak self] (result) in
                    CustomLoader.shared.hide()
                    guard let `self` = self else {
                        return
                    }
                    switch result {
                    case .success(let response):
                        print("Response",response)
                        guard let data = response.resultData as? Data else {
                            return
                        }
                        self.createEphemeralKeyModel = JSONDecoder().convertDataToModel(data)
                        if response.statusCode == 200 {
                            self.viewModel.createPaymentIndent(params: ["currency":self.objFlightSearchResponseData?.priceCurrency ?? "USD","amount":"\(Int(self.finalPricing ?? 0.0))","customer":self.customerModel?.id ?? "", "automatic_payment_methods[enabled]":"true"]) { (result) in
                                switch result {
                                case .success(let response):
                                    print("Response",response)
                                    guard let data = response.resultData as? Data else {
                                        return
                                    }
                                    self.createIntentModel = JSONDecoder().convertDataToModel(data)
                                    //self.configureStripePaymentSheet(intent: self.createIntentModel, emphral: self.createEphemeralKeyModel)
                                    let clientSecret = self.createIntentModel?.clientSecret
                                    // Call the completion block with the client secret or an error
                                    completion(clientSecret, nil);
                                case .failure(let error):
                                    print("Error",error)
                                }
                            }
                        }
                    case .failure(let error):
                        print("Error",error)
                    }
                }
                return
            case .failure(let error):
                print(error)
                return
            }
        }
    }

    func applePayContext(_ context: STPApplePayContext, didCompleteWith status: STPPaymentStatus, error: Error?) {
          switch status {
        case .success:
            // Payment succeeded, show a receipt view
            break
        case .error:
            // Payment failed, show the error
            break
        case .userCancellation:
            // User cancelled the payment
            break
        @unknown default:
            fatalError()
        }
    }
}

extension Encodable {
    func toJSONString() -> String? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    func toJsonDict() -> [String:Any]? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let dict = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String:Any]
            return dict
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
