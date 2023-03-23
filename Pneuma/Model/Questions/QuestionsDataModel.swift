//
//  QuestionsDataModel.swift
//  Pneuma
//
//  Created by Chitra on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
import UIKit

class QuestionsTableDataSourceModel: NSObject {
    var listArray = [QuestionsDataModel]()
}

enum QuestionState {
    case active
    case complete
    case inComplete
}

enum QuestionType {
    case textfield
    case season
    case travelPurpose
}

struct QuestionsDataModel {
    var question: String
    var state: QuestionState
    var type: QuestionType
    var isLast: Bool = false
}
struct StoreAnswerDataModel: Codable {
    var data: [StoreAnswerRequestModel]?
}
struct StoreAnswerRequestModel: Codable {
    var answers: String?
    var question_id:String?
}

struct NewStoreAnswerRequestModel: Codable {
    
}

struct StoreAnswerResponseModel: Codable {
    var status: Bool?
    var message: String?
}



struct GetQuestionsResponseModel: Codable {
    //var status: String?
    var message: String?
    var data: [QuestionModel]?
}

class QuestionModel: Codable {
    var id: Int?
    var title: String?
    var created_at: String?
    var updated_at: String?
}

struct GetAnswersResponseModel: Codable {
    //var status: String?
    var message: String?
    var data: [AnswerModel]?
}

class AnswerModel: Codable {
    var question_id: Int?
    var id : Int?
    var question: String?
    var answer: String?
    var created_at: String?
    var updated_at: String?
}
