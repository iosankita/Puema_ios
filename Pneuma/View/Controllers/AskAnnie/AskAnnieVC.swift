//
//  AskAnnieVC.swift
//  Pneuma
//
//  Created by MacBook Pro on 13/11/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import AWSLex

enum ReservationType {
    case flight
    case hotel
    case ride
}

struct FlightSearchParamAnnie {
    var flight_id : String?
    var reservationType : String?
    var originLocation : String?
    var destinationLocation : String?
    var departureDate : String?
    var tripRound : String?
    var slotBook : String?

    init(flight_id : String?, reservationType : String?, originLocation : String?, destinationLocation : String?, departureDate : String?, tripRound : String?, slotBook : String?) {
        self.flight_id = flight_id
        self.reservationType = reservationType
        self.originLocation = originLocation
        self.destinationLocation = destinationLocation
        self.departureDate = departureDate
        self.tripRound = tripRound
        self.slotBook = slotBook
    }
}

struct HotelSearchParamAnnie {
    var hotel_code : String?
    var reservationType : String?
    var location : String?
    var checkin_date : String?
    var checkout_date : String?
    var number_of_rooms : String?
    var adults : String?

    init(hotel_code : String?, reservationType : String?, location : String?, checkin_date : String?, checkout_date : String?, number_of_rooms : String?, adults : String?) {
        self.hotel_code = hotel_code
        self.reservationType = reservationType
        self.location = location
        self.checkin_date = checkin_date
        self.checkout_date = checkout_date
        self.number_of_rooms = number_of_rooms
        self.adults = adults
    }
}

class AskAnnieVC: UIViewController , AWSLexInteractionDelegate , UITextFieldDelegate, AWSLexVoiceButtonDelegate{
    
    var interactionKit : AWSLexInteractionKit?

    
    func interactionKit(_ interactionKit: AWSLexInteractionKit, onError error: Error) {
        print(error.localizedDescription)
    }
    
    func interactionKit(_ interactionKit: AWSLexInteractionKit, switchModeInput: AWSLexSwitchModeInput, completionSource: AWSTaskCompletionSource<AWSLexSwitchModeResponse>?) {
        if isFromVoice == false {
            guard let response = switchModeInput.outputText else {
                print("No reply from bot")
                return
            }
            DispatchQueue.main.async {
                self.isFromVoice = true
                self.viewListenContainer.isHidden = true
                self.viewModel.addAnswer(answer: response, tag: self.questionNumber, isFromVoice: self.isFromVoice)
                self.questionNumber = self.questionNumber + 1
                self.sendButton.isEnabled = true
                self.tableView.reloadData()
            }
        }
    }
    

    //MARK:- IBOUTLETS
    //@IBOutlet weak var customNav: CustomNavigationView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAskAnnie: AWSLexVoiceButton!
    @IBOutlet weak var viewTFNBtnContainer: UIView!
    @IBOutlet weak var questionSendField : UITextField!
    @IBOutlet weak var sendButton : UIButton!
    @IBOutlet weak var viewListenContainer: UIView!
    
    //MARK:- VARIABLES
    let cellId = "userCell"
    let cellId2 = "annieCell"
    var viewModel = AskAnnieVM()
    private var questionNumber = 0
    var isFromVoice = Bool()
    var annieSearchParams : FlightSearchParamAnnie = FlightSearchParamAnnie(flight_id: nil, reservationType: nil, originLocation: nil, destinationLocation: nil, departureDate: nil, tripRound: nil, slotBook: nil)
    var annieHotelSearchParams : HotelSearchParamAnnie = HotelSearchParamAnnie(hotel_code: nil, reservationType: nil, location: nil, checkin_date: nil, checkout_date: nil, number_of_rooms: "1", adults: "1")
    var reservationTypeAnnie : ReservationType = .flight

    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.setTitle("", for: .normal)
        sendButton.setTitle("", for: .normal)
        self.registerCell()

        //self.customNav.delegate = self
        setupLex()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupLex() {
        self.interactionKit = AWSLexInteractionKit(forKey: "chatConfig")
        self.interactionKit?.interactionDelegate = self
        (self.btnAskAnnie as AWSLexVoiceButton).delegate = self
    }
    
    //MARK:- IBACTIONS
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func sendQuestionAction(_ sender: Any) {
        isFromVoice = false
        if questionSendField.text?.count ?? 0 > 0 {
            self.viewModel.addQuestion(question: questionSendField.text ?? "", tag: questionNumber, isFromVoice: false)
            self.tableView.reloadData()
            self.sendButton.isEnabled = false
            self.interactionKit?.text(inTextOut: questionSendField.text ?? "")
            self.questionSendField.text = ""
        }
        
    }
    
    //MARK: - PRIVATE FUNCTIONS
    private func registerCell() {
        self.tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: cellId)
        self.tableView.register(UINib(nibName: "AnnieCell", bundle: nil), forCellReuseIdentifier: cellId2)
        self.tableView.dataSource = self.viewModel.tableDataSource
        self.tableView.delegate = self
    }

    private func goToBottom() {
        guard self.viewModel.tableDataSource.listArray.count > 0 else { return }
        let indexPath = IndexPath(row: self.viewModel.tableDataSource.listArray.count - 1, section: 0)//(forRow: self.viewModel.tableDataSource.listArray.count - 1, inSection: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        tableView.layoutIfNeeded()
    }
    
    //MARK: - AWSLexVoiceButtonDelegate
    func voiceButton(_ button: AWSLexVoiceButton, on response: AWSLexVoiceButtonResponse) {
        //self.viewListenContainer.isHidden = false
        // `inputTranscript` is the transcript of the voice input to the operation
        if let inputTranscript = response.inputTranscript {
            DispatchQueue.main.async{
                print("Input Transcript: " + inputTranscript)
                //self.input.text = "\"\(inputTranscript)\""
                if inputTranscript.count > 0 {
                    self.isFromVoice = true
                    self.viewModel.addQuestion(question: inputTranscript, tag: self.questionNumber, isFromVoice: true)
                    self.tableView.reloadData()
                    self.goToBottom()
                    //                    self.sendButton.isEnabled = false
                    //                    self.interactionKit?.text(inTextOut: inputTranscript)
                    //                    self.questionSendField.text = ""
                }
            }
        }

        if let outputText = response.outputText {
            print("Output Transcript: " + outputText)
            DispatchQueue.main.async {
                //self.viewListenContainer.isHidden = true
                self.viewModel.addAnswer(answer: outputText, tag: self.questionNumber, isFromVoice: true)
                    if let dict = response.sessionAttributes as? [String:Any] {
                        print(dict)
                        if let dictReservation = dict["currentReservation"] {
                            print("Current Reservation :",dictReservation)
                            let str = dictReservation as? String ?? ""
                            if let dictRes = self.convertStringToDictionary(text: str) {
                                print(dictRes)
                                if let reservationType = dictRes["ReservationType"] as? String{
                                    if reservationType == "Flight" {
                                        if let id = dict["flight_id"] as? String {
                                            self.annieSearchParams.flight_id = id
                                        }
                                        self.reservationTypeAnnie = .flight
                                        self.annieSearchParams.reservationType = reservationType
                                        if let destinationLocation = dictRes["destinationLocation"] as? String{
                                            self.annieSearchParams.destinationLocation = destinationLocation
                                        }
                                        if let originLocation = dictRes["originLocation"] as? String{
                                            self.annieSearchParams.originLocation = originLocation
                                        }
                                        if let departureDate = dictRes["departureDate"] as? String{
                                            self.annieSearchParams.departureDate = departureDate
                                        }
                                        if let tripRound = dictRes["tripRound"] as? String{
                                            self.annieSearchParams.tripRound = tripRound
                                        }
                                    }else if reservationType == "Hotel" {
                                        self.reservationTypeAnnie = .hotel
                                        self.annieHotelSearchParams.reservationType = reservationType
                                        print("HOTEL SEARCH ::",dictRes)
                                        if let id = dict["HotelCode"] as? String {
                                            print("HOTEL ID ::",id)
                                            self.annieHotelSearchParams.hotel_code = id
                                        }
                                        if let location = dictRes["Location"] as? String{
                                            print(location)
                                            self.annieHotelSearchParams.location = location
                                        }
                                        if let checkInDate = dictRes["CheckInDate"] as? String{
                                            print(checkInDate)
                                            self.annieHotelSearchParams.checkin_date = checkInDate
                                        }
                                        if let checkOutDate = dictRes["CheckOutDate"] as? String{
                                            print(checkOutDate)
                                            self.annieHotelSearchParams.checkout_date = checkOutDate
                                        }
                                    }else if reservationType == "Ride" {
                                        self.reservationTypeAnnie = .ride
                                    }
                                }
                            }
                        }
                        if let appContext = dict["appContext"] {
                            let str = appContext as? String ?? ""
                            if let dictAppContext = self.convertStringToDictionary(text: str) {
                                print("It is a Dictionary", dictAppContext)
                                if let responseCard = dictAppContext["responseCard"] as? [String:Any] {
                                    print("responseCard", responseCard)
                                    if let genericAttachments = responseCard["genericAttachments"] as? [[String:Any]] {
                                        print("genericAttachments", genericAttachments)
                                        if let attachments = genericAttachments[0] as? [String:Any]{
                                            print(attachments)
                                            if let button = attachments["buttons"] as? [[String:Any]] {
                                                if let finalDict = button[0] as? [String:Any] {
                                                    print(finalDict["text"])
                                                    if let text = finalDict["text"] as? String {
                                                        if text == "Book" && outputText == "Click the button to book flight ticket. Thank you!" || text == "Book" && outputText == "Click the button to book. Thank you!"{
                                                            self.viewModel.addAnswer(answer: "BOOK", tag: self.questionNumber, isFromVoice: true)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

//                    if annieResponse?[0].appContext?.responseCard?.genericAttachments?[0].buttons?[0].text == "Book" {
//                        self.viewModel.addAnswer(answer: "BOOK", tag: self.questionNumber, isFromVoice: true)
//                    }

//                    if outputText == "Click the button to book flight ticket. Thank you!" {
//                        self.viewModel.addAnswer(answer: "BOOK", tag: self.questionNumber, isFromVoice: true)
//                    }

//                    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
//                    // here "decoded" is of type `Any`, decoded from JSON data
//
//                    // you can now cast it with the right type
//                    if let dictFromJSON = decoded as? [String:String] {
//                        // use dictFromJSON
//                    }

                self.questionNumber = self.questionNumber + 1
                self.sendButton.isEnabled = true
                self.tableView.reloadData()
                self.goToBottom()
            }
        }

    }

    public func voiceButton(_ button: AWSLexVoiceButton, onError error: Error) {
        DispatchQueue.main.async {
            //self.viewListenContainer.isHidden = true
        }
        print("error \(error)")
    }

    func convertStringToDictionary(text: String) -> [String:Any]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}

//MARK: - CUSTOM NAVIGATION VIEW DELEGATE
extension AskAnnieVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressLeft button: UIButton) {
        //
    }
}
