//
//  InitialQuestionsVM.swift
//  Pneuma
//
//  Created by Chitra on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class InitialQuestionsVM: NSObject {
    
    // MARK: - VARIABLES
    var answerRequestModel: [StoreAnswerRequestModel]?
    var apiServices: OnboardingQuestionsApiServices
    var answerResponseModel: StoreAnswerResponseModel?
    var getQuestionsResponseModel: GetQuestionsResponseModel?
    var getAnswersResponseModel: GetAnswersResponseModel?
    let tableDataSource = QuestionsTableDataSource()
    var isCompleted = false
    var answer = [Any]()
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = OnboardingQuestionsApiServices()
        self.answerRequestModel = [StoreAnswerRequestModel]()
        self.answerResponseModel = StoreAnswerResponseModel()
        self.getQuestionsResponseModel = GetQuestionsResponseModel()
        super.init()
        //self.getList()
    }
    
    func getList(completion: @escaping ApiResponseCompletion) {
        self.apiServices.getAllQuestions { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetQuestionsResponseModel? = JSONDecoder().convertDataToModel(data)
                self.getQuestionsResponseModel = model
                if let model = self.getQuestionsResponseModel , let array = model.data  {
                    var dataArray = [QuestionsDataModel]()
                    for question in array {
                        var dataModel = QuestionsDataModel(question: (question.title ?? ""), state: QuestionState.active, type: QuestionType.textfield)
                        if (array.last?.id == question.id) {
                           dataModel = QuestionsDataModel(question: (question.title ?? ""), state: QuestionState.active, type: QuestionType.textfield, isLast: true)
                        }
                        dataArray.append(dataModel)
                        
                        
                    }
                    
                    self.tableDataSource.listArray = dataArray                }
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    
    // MARK: - VALIDATIONS
    func updateActiveQues() {
        if let activeQuesIndex = self.tableDataSource.listArray.firstIndex(where: { $0.state == .active }) {
            for i in 0..<self.tableDataSource.listArray.count {
                if i <= activeQuesIndex {
                    self.tableDataSource.listArray[i].state = .complete
                } else if i == activeQuesIndex+1 {
                    self.tableDataSource.listArray[i].state = .active
                } else {
                    self.tableDataSource.listArray[i].state = .inComplete
                }
            }
            if self.tableDataSource.listArray.last?.state == .active {
                self.isCompleted = true
            }
        }
    }
    
    func storeAnswers(_ param : [String:Any] , completion: @escaping ApiResponseCompletion) {
        //let dictionary = JSONHelper<HardwareUpdateModel>().toDictionary(model: model)
             //      return dictionary
//        let params = JSONEncoder().toDictionary(model: self.answerRequestModel)
//        var parameters : [String:Any] = ["data":jsonObj]

          
          ///Calling api service method
        self.apiServices.storeAnswers(param) { (result) in
              switch result {
              case .success(let response):
                  guard let data = response.resultData as? Data else {
                      completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                      return
                  }
                  let model: StoreAnswerResponseModel? = JSONDecoder().convertDataToModel(data)
                  self.answerResponseModel = model
                  completion(.success(response))
              case .failure(let error):
                  ///Handle failure response
                  completion(.failure(error))
              }
          }
    }
    
    func getAnswerList(completion: @escaping ApiResponseCompletion) {
        self.apiServices.getAllAnswers { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetAnswersResponseModel? = JSONDecoder().convertDataToModel(data)
                self.getAnswersResponseModel = model
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
}

// MARK: - TABLE FUNCTIONS
extension InitialQuestionsVM {
    func selectItem(at indexPath: IndexPath) {

    }
}

extension UIViewController{
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
