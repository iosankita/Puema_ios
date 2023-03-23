//
//  AskAnnieDataModel.swift
//  Pneuma
//
//  Created by MacBook Pro on 13/11/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

enum QA {
    case Q
    case A
    case BOOK
}

class AskAnnieDataSourceModel: NSObject {
    var listArray = [AskAnnieModel]()
}

class AskAnnieModel {
    var question: String
    var answer: String
    var tag: Int
    var isFrom:QA
    var isFromVoice: Bool
    
    init(tag:Int, question: String, answer: String, isfrom: QA, isFromVoice: Bool) {
        self.tag = tag
        self.question = question
        self.answer = answer
        self.isFrom = isfrom
        self.isFromVoice = isFromVoice
    }
}

