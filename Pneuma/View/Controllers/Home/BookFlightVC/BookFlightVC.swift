//
//  BookFlightVC.swift
//  Pneuma
//
//  Created by Jatin on 26/02/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import Speech
import GLWalkthrough
import Speech

enum DateFrom {
    case bookFirstDate
    case bookSecondDate
    case bookPassenger
}

class BookFlightVC: UIViewController, DateDelegate, FlightSelectedDelegate, AdditionalOptionDelegate,AlertProtocol {

    // MARK: - IBOUTLETS
    @IBOutlet weak var roundTripButton: UIButton!
    @IBOutlet weak var oneWayButton: UIButton!
    @IBOutlet weak var swapAddressButton: UIButton!
    @IBOutlet weak var originAddressLabel: UILabel!
    @IBOutlet weak var destinationAddressLabel: UILabel!
    @IBOutlet weak var firstTimeLabel: UILabel!
    @IBOutlet weak var secondTimeLabel: UILabel!
    @IBOutlet weak var ticketTypeLabel: UILabel!
    @IBOutlet weak var secondTimeContainerView: UIView!
    @IBOutlet weak var customNavigationView: UIView!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var askAnnieButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - VARIABLES
    let objSpeaker = Speaker()
    var coachMarker:GLWalkThrough!
    public private(set) var isRecording = false
    private var audioEngine =  AVAudioEngine()
    private var inputNode : AVAudioInputNode?
    private var audioSession :AVAudioSession? = AVAudioSession()
    //MARK: - Local Properties
    private var recognitionRequest : SFSpeechAudioBufferRecognitionRequest?
    
    let speechRecognizer        = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
       var recognitionTask         : SFSpeechRecognitionTask?
    
    
    var viewModel: BookFlightVM!
    var isFromDate1 : Bool = false
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.dateMonth.rawValue
        return formatter
    }()
    var departureDate : Date? = Date()
    var returnDepartureDate : Date? = Date()
    var originCity : String = ""
    var destinationCity : String = ""
    var seatType : String = "Y"
    var numberOfAdults : Int = 1
    var numberOfChildren : Int = 0
    var numberOfInfants : Int = 0
    var age : [Any]?
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        handleWalkthrought()
        checkPermissions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupInitialUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.customizeUI()
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func handleWalkthrought(){
        
        coachMarker = GLWalkThrough()
        coachMarker.dataSource = self
        coachMarker.delegate = self
        coachMarker.show()
   
    }
    func setupViewModel(_ viewModel: BookFlightVM) {
        self.viewModel = viewModel
    }
    
    // MARK: - IBACTIONS
    @IBAction func originAddressButtonAction(_ sender: UIButton) {
        self.gotoChooseAddress(type: .origin)
    }
    
    @IBAction func destinationAddressButtonAction(_ sender: UIButton) {
        self.gotoChooseAddress(type: .destination)
    }
    
    @IBAction func firstTimeButtonAction(_ sender: UIButton) {
        isFromDate1 = true
        self.gotoChooseDateVC()
    }
    
    @IBAction func secondTimeButtonAction(_ sender: UIButton) {
        isFromDate1 = false
        self.gotoChooseDateVC()
    }
    
    @IBAction func seatTypeButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.loadAdditionalOptionVC()
        vc.delegate = self
        vc.userSelectedClass = self.seatType
        vc.numberOfChildren = numberOfChildren
        vc.numberOfAdults = numberOfAdults
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func roundTripButtonAction(_ sender: UIButton) {
        self.oneWayButton.removeBottomBoder()
        self.oneWayButton.setTitleColor(.lightLavendar, for: .normal)
        self.roundTripButton.setTitleColor(.white, for: .normal)
        self.roundTripButton.addBottomBorderWithColor(.white, width: 2)
        self.secondTimeContainerView.isHidden = false
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        self.returnDepartureDate = Date.tomorrow
    }
    
    @IBAction func oneWayButtonAction(_ sender: UIButton) {
        self.roundTripButton.removeBottomBoder()
        self.roundTripButton.setTitleColor(.lightLavendar, for: .normal)
        self.oneWayButton.setTitleColor(.white, for: .normal)
        self.oneWayButton.addBottomBorderWithColor(.white, width: 2)
        self.secondTimeContainerView.isHidden = true
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        self.returnDepartureDate = nil
    }
    
    @IBAction func swapAddressButtonAction(_ sender: UIButton) {
        self.swapAddress()
    }
    
    @IBAction func searchTicketButtonAction(_ sender: UIButton) {

        if self.originAddressLabel.text! == "Select Origin"{
            self.showAlertWithText("Please select origin")
            return
        } else if self.destinationAddressLabel.text! == "Select Destination" {
            self.showAlertWithText("Please select destination")
            return
        }

        if viewModel.screenType == .planMyTrip {
            let vc = UIStoryboard.loadRideDetailVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = UIStoryboard.loadSearchFlightsVC()
            let origin = self.originAddressLabel.text ?? ""
//            else { print("origin blank") return }
            let destination = self.destinationAddressLabel.text ?? ""
            let date = self.firstTimeLabel.text ?? ""
            
            vc.navTitle = originCity + "-" + destinationCity + "," + date
            vc.departureDate = departureDate
            if returnDepartureDate == nil {
                vc.returnDate = nil
            }else {
                vc.returnDate = returnDepartureDate
            }
            vc.origin = originCity
            vc.destination = destinationCity
            vc.selectedClass = self.seatType
            vc.numberOfAdults = self.numberOfAdults
            vc.numberOfChildren = self.numberOfChildren
            vc.numberOfInfants = self.numberOfInfants
            vc.age = self.age
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btnAskAnnieAction(_ sender: Any) {
        objSpeaker.speak(msg: "Please Speak your Origin")
        sleep(3)
        if self.isRecording { self.stopRecording() } else { self.startRecording() }
        self.isRecording.toggle()
//        let vc = UIStoryboard.loadAskAnnieVC()
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func gotoChooseAddress(type: ChooseAddressTypeEnum) {
        let vc = UIStoryboard.loadChooseAddressVC()
        let vm = ChooseAddressVM(locationType: type)
        vc.setupViewModel(vm)
        vc.delegate = self
        vc.isfrom = .flight
        if type == .origin{
            vc.selectedCityName = self.originAddressLabel.text ?? "" == "Select Origin" ? "" : self.originAddressLabel.text ?? ""
        }else{
            vc.selectedCityName = self.destinationAddressLabel.text ?? "" == "Select Destination" ? "" : self.destinationAddressLabel.text ?? ""
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func gotoChooseDateVC() {
        let vc = UIStoryboard.loadChooseDateVC()
        vc.dateDelegate = self
        if isFromDate1 {
            vc.isFromBookAFlightDate1 = true
            vc.selectedDate = self.departureDate
            vc.curentdate = Date()
            vc.endDate = self.returnDepartureDate ?? Date()
        }else {
            vc.isFromBookAFlightDate2 = true
            vc.selectedDate = self.returnDepartureDate
            vc.curentdate = self.departureDate  ?? Date()
            vc.endDate = self.returnDepartureDate ?? Date()
        }
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupInitialUI() {
        self.roundTripButton.addBottomBorderWithColor(.white, width: 2)
    }
    
    private func customizeUI() {
        self.customNavigationView.roundBottomCorners()
    }
    
    private func swapAddress() {
        let originAddress = self.originAddressLabel.text
        self.originAddressLabel.text = self.destinationAddressLabel.text
        self.destinationAddressLabel.text = originAddress
        let originNewCity = originCity
        self.originCity = self.destinationCity
        self.destinationCity = originNewCity
    }
    
    private func setupUI() {
        self.originAddressLabel.text = "Select Origin"
        self.originAddressLabel.textColor = .lightGray
        self.destinationAddressLabel.text = "Select Destination"
        self.destinationAddressLabel.textColor = .lightGray
        self.ticketTypeLabel.text = "Select Class"

        if self.viewModel.screenType == .planMyTrip {
            self.navigationTitleLabel.text =  "Plan My Trip"
            self.askAnnieButton.isHidden = true
            self.searchButton.setTitle("SEARCH", for: .normal)
        } else {
            self.searchButton.setTitle("SEARCH TICKETS", for: .normal)
        }

        self.firstTimeLabel.text = self.dateFormatter.string(from: Date())
        self.departureDate = Date()

        self.secondTimeLabel.text = self.dateFormatter.string(from: Date.week)
        self.returnDepartureDate = Date.week
        let type = seatType.capitalized == SeatTitle.S.rawValue ? SeatTitle.S.title : seatType.capitalized == SeatTitle.C.rawValue ? SeatTitle.C.title : seatType.capitalized == SeatTitle.F.rawValue ? SeatTitle.F.title : SeatTitle.Y.title
        self.ticketTypeLabel.text = "\(numberOfAdults) Passenger, \(type.capitalized)"
    }

    // MARK: - Delegate method
    func setDate(date: Date, from: DateFrom) {
        switch from {
        case .bookFirstDate:
            self.firstTimeLabel.text = self.dateFormatter.string(from: date)
            self.departureDate = date
            break
        case .bookSecondDate:
            self.secondTimeLabel.text = self.dateFormatter.string(from: date)
            self.returnDepartureDate = date
            break
        case .bookPassenger:
            break
        }
    }

    func setFlight(airpotName:String, cityName:String, from:ChooseAddressTypeEnum) {
        switch from {
        case .origin:
            self.originCity = cityName
            self.originAddressLabel.text = cityName + " - " + airpotName
            self.originAddressLabel.textColor = .black
            break
        case .destination:
            self.destinationCity = cityName
            self.destinationAddressLabel.text = cityName + " - " + airpotName
            self.destinationAddressLabel.textColor = .black
            break
        default:
            break
        }
    }
    
    func setSeatTypeAndPeople(seatType: String, Adults: Int, Children: Int, Infants: Int, childrenAge :NSMutableArray) {
        self.numberOfAdults = Adults
        self.numberOfChildren = Children
        self.numberOfInfants = Infants
        self.seatType = seatType
        self.age = childrenAge as? [Any]
        let type = seatType.capitalized == SeatTitle.S.rawValue ? SeatTitle.S.title : seatType.capitalized == SeatTitle.C.rawValue ? SeatTitle.C.title : seatType.capitalized == SeatTitle.F.rawValue ? SeatTitle.F.title : SeatTitle.Y.title
       let passenger =  (numberOfAdults + numberOfChildren)
        self.ticketTypeLabel.text = "\(passenger) Passenger, \(type.capitalized)"

    }

}


// MARk: --
extension BookFlightVC: GLWalkThroughDelegate {
    func didSelectNextAtIndex(index: Int) {
        if index == 1 {
            coachMarker.dismiss()
          
        }
    }
    
    func didSelectSkip(index: Int) {
        coachMarker.dismiss()
    }
    
    
}
extension BookFlightVC: GLWalkThroughDataSource {
    func getTabbarFrame(index:Int) -> CGRect? {
        if let bar = self.tabBarController?.tabBar.subviews {
            var idx = 0
            var frame:CGRect!
            for view in bar {
                if view.isKind(of: NSClassFromString("UITabBarButton")!) {
                    print(view.description)
                    if idx == index {
                        frame =  view.frame
                    }
                    idx += 1
                }
            }
            return frame
        }
        return nil
    }
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func configForItemAtIndex(index: Int) -> GLWalkThroughConfig {
        let overlaySize:CGFloat = Helper.shared.hasTopNotch ? 50 : 50
        switch index {
        case 0:
            var config = GLWalkThroughConfig()
            config.title = "ANNIE is your assistant"
            config.subtitle = "Activate ANNIE by tapping button"
            config.frameOverWindow = CGRect(x: askAnnieButton.frame.origin.x, y:askAnnieButton.frame.origin.y - 25, width: overlaySize, height: overlaySize)
            config.position = .bottomRight
            return config
        default:
            return GLWalkThroughConfig()
        }
    }
    
    
}

extension BookFlightVC{
  
    
    // MARK: - Speech recognition
    private func startRecording() {
        // MARK: 1. Create a recognizer.
        guard let recognizer = SFSpeechRecognizer(), recognizer.isAvailable else {
            Toast.shared.showAlert(type: .notification, message: "Speech recognizer not available.")
            return
        }

        // MARK: 2. Create a speech recognition request.
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest?.shouldReportPartialResults = true

        recognizer.recognitionTask(with: recognitionRequest!) { (result, error) in
            guard error == nil else {
                Toast.shared.showAlert(type: .notification, message: error?.localizedDescription ?? "Please try again.")
                return }
            guard let result = result else { return }

            print("got a new result: \(result.bestTranscription.formattedString), final : \(result.isFinal)")
            if result.isFinal {
                DispatchQueue.main.async {
                    self.updateUI(withResult: result)
                }
            }
        }

        // MARK: 3. Create a recording and classification pipeline.
        audioEngine = AVAudioEngine()

        inputNode = audioEngine.inputNode
        let recordingFormat = inputNode?.outputFormat(forBus: 0)
        inputNode?.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.recognitionRequest?.append(buffer)
        }

        // Build the graph.
        audioEngine.prepare()

        // MARK: 4. Start recognizing speech.
        do {
            // Activate the session.
            audioSession = AVAudioSession.sharedInstance()
            try audioSession?.setCategory(.record, mode: .spokenAudio, options: .duckOthers)
            try audioSession?.setActive(true, options: .notifyOthersOnDeactivation)

            // Start the processing pipeline.
            try audioEngine.start()
        } catch {
            Toast.shared.showAlert(type: .validationFailure, message: error.localizedDescription)
               }
    }
    private func updateUI(withResult result: SFSpeechRecognitionResult) {
        // Update the UI: Present an alert.
        let ac = UIAlertController(title: "You said:",
                                   message: result.bestTranscription.formattedString,
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
    private func stopRecording() {
        // End the recognition request.
        recognitionRequest?.endAudio()
        recognitionRequest = nil

        // Stop recording.
        audioEngine.stop()
        inputNode?.removeTap(onBus: 0) // Call after audio engine is stopped as it modifies the graph.

        // Stop our session.
        try? audioSession?.setActive(false)
        audioSession = nil
    }
    // MARK: - Privacy
    private func checkPermissions() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized: break
                default: self.handlePermissionFailed()
                }
            }
        }
    }
    private func handlePermissionFailed() {
        // Present an alert asking the user to change their settings.
        let ac = UIAlertController(title: "This app must have access to speech recognition to work.",
                                   message: "Please consider updating your settings.",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Open settings", style: .default) { _ in
            let url = URL(string: UIApplication.openSettingsURLString)!
            UIApplication.shared.open(url)
        })
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(ac, animated: true)
        Toast.shared.showAlert(type: .notification, message: "Speech recognition not available.")
        // Disable the record button.
       // askAnnieButton.isUserInteractionEnabled = false
       // recordButton.setTitle("Speech recognition not available.", for: .normal)
    }
}



enum SeatTitle : String {
case Y , S , C, F
    var title: String {
        switch self {
        case .Y:
            return "ECONOMY"
        case .S:
            return "PREMIUM ECONOMY"
        case .C:
            return "BUSINESS"
        case .F:
            return   "FIRST-CLASS"
        }
    }
}
