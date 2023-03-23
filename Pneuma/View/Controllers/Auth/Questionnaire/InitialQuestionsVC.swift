//
//  InitialQuestionsVC.swift
//  Pneuma
//
//  Created by Chitra on 01/03/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit
import Alamofire

class InitialQuestionsVC: UIViewController, AlertProtocol {

    //MARK:- IBOUTLETS
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK:- VARIABLES
    private let cellID = "QuestionnaireTVC"
    var viewModel = InitialQuestionsVM()
    var questionPrsent : Int = 1
    var answers = [String]()
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.customiseUI()
    }

    //MARK:- IBACTIONS
    @IBAction func nextAction(_ sender: Any) {
        if let errorMsg = self.checkValidation() {
            self.showAlertWithText(errorMsg)
            return
        }
        if self.viewModel.isCompleted {

//            for n in 0...self.viewModel.tableDataSource.listArray.count - 1 {
//                if let cell = self.tableView.cellForRow(at: IndexPath(row: n, section: 0)) as? QuestionnaireTVC, let text = cell.textField.text {
//
//                }
//            }
            var question_ids = [String]()
            if let questionArray = self.viewModel.getQuestionsResponseModel?.data {
                for question in questionArray {
                    question_ids.append("\(question.id ?? 0)")
                }
            }
            
            let userTagObject  = NSMutableArray()
            for index in 0..<question_ids.count {
                let dictPrice = NSMutableDictionary()
                dictPrice.setValue(question_ids[index], forKey: "question_id")
                dictPrice.setValue(answers[index], forKey: "answer")
                userTagObject.add(dictPrice)
                
            }
           let jsonString = json(from: userTagObject)
            print(jsonString)
            self.storeAnswers(param: ["data":userTagObject])
        }else {
            //FIXME:- Store data in Model
            self.viewModel.updateActiveQues()
            self.updateButtonUI()
            self.tableView.reloadData {
                var completQueNumber:Int = 1
                for (i,ques) in self.viewModel.tableDataSource.listArray.enumerated(){
                    if ques.state == .active{
                        completQueNumber = i
                    }
                }
//                let question = self.viewModel.tableDataSource.listArray[completQueNumber + 1].question
//                let height = question.height(constraintedWidth: self.view.frame.size.width - 66, font: UIFont(name: "Poppins-SemiBold", size: 16.0) ?? .systemFont(ofSize: 16.0))
//                if height < 40{
//                    let newHeight = 40 + 20 + 16 + 45
//                    self.tableViewHeight.constant += CGFloat(newHeight)
//                }else {
//                    self.tableViewHeight.constant += height + 20 + 16
//                }
                self.tableViewHeight.constant = CGFloat(completQueNumber + 1) * CGFloat(105)
//                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    //self.tableViewHeight.constant = self.tableView.contentSize.height
//                }
            }
        }
    }
    
    //MARK:- PRIVATE FUNCTIONS
    private func customiseUI() {
        greetingLabel.text = "Hi, \(AppCache.shared.currentUser?.name ?? "User")!"
    }
    
    private func updateButtonUI() {
        if let activeQuesIndex = self.viewModel.tableDataSource.listArray.firstIndex(where: { $0.state == .active }) {
            if activeQuesIndex == self.viewModel.tableDataSource.listArray.count-1 {
                self.viewModel.isCompleted = true
                self.nextButton.setTitle("COMPLETE", for: .normal)
                self.tableView.scrollToBottom(animated: true)
            }
        }
    }
    
    private func checkValidation() -> String? {
        if let activeQuesIndex = self.viewModel.tableDataSource.listArray.firstIndex(where: { $0.state == .active }) {
            if self.viewModel.tableDataSource.listArray[activeQuesIndex].type == .textfield {
                if let cell = self.tableView.cellForRow(at: IndexPath(row: activeQuesIndex, section: 0)) as? QuestionnaireTVC, let text = cell.textField.text {
                    if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        return (LocalizedStringEnum.answerTheQuestion.localized)
                    }else {
                        self.answers.append(text)
                    }
                }
            } else if let cell = self.tableView.cellForRow(at: IndexPath(row: activeQuesIndex, section: 0)) as? QuestionnaireTVC {
                if cell.selectedOptionTag == nil {
                    return (LocalizedStringEnum.chooseOption.localized)
                }
            }
            return nil
        }
        return nil
    }
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        self.tableView.dataSource = self.viewModel.tableDataSource
        CustomLoader.shared.show()
        self.viewModel.getList { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(_):
                //Handle UI or navigation
                self.tableView.dataSource = self.viewModel.tableDataSource
                self.tableView.reloadData()
                self.view.setNeedsLayout()
                return
            case .failure(_):
                return
            }
        }
    }
}
extension InitialQuestionsVC {

//    func StoreQA(){
//        CustomLoader.shared.show()
//        let newHeaders: HTTPHeaders = [
//            "Accept": "application/json",
//            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
//        ]
//
//      //  "http://ec2-3-145-217-61.us-east-2.compute.amazonaws.com/
//        let param = self.viewModel.answerRequestModel
//
//        AF.upload(multipartFormData: { multipartFormData in
//            for (index,_) in param.question_ids!.enumerated() {
//                multipartFormData.append(Data(param.question_ids![index].utf8), withName: "question_ids[\(index)]")
//                multipartFormData.append(Data(param.answers![index].utf8), withName: "answers[\(index)]")
//            }
//        },to: AppConstants.Urls.apiBaseUrl + "api/save-signup-answers", method: .post, headers: newHeaders).responseJSON { response in
//            print(response)
//            switch response.result {
//            case .success(let json):
//                CustomLoader.shared.hide()
//                print(json)
//                if let json = json as? [String:Any] {
//                    if let status = json["status"] as? Int {
//                        if status == 1 {
//                            AppCache.shared.isInitialQuestionAnswered = true
//                            let vc = UIStoryboard.loadHomeVC()
//                            self.navigationController?.pushViewController(vc, animated: true)
//                        }
//                    }
//                }
//            case .failure(let error):
//                print(error)
//                CustomLoader.shared.hide()
//                self.showAlertWithText(error.localizedDescription)
//            }
//        }
//    }

    func storeAnswers(param : [String : Any]) {
           CustomLoader.shared.show()
          self.viewModel.storeAnswers(param) { [weak self] (result) in
               CustomLoader.shared.hide()
               guard let `self` = self else {
                   return
               }
               switch result {
               case .success(_):
                   //Handle UI or navigation
                   self.showAlertWithText(self.viewModel.answerResponseModel?.message ?? "", buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
                       AppCache.shared.isInitialQuestionAnswered = true
                       let vc = UIStoryboard.loadHomeVC()
                       self.navigationController?.pushViewController(vc, animated: true)
                   }
                   return
               case .failure(let error):
                   self.showAlertWithText(error.message)
               }
           }
       }
}
