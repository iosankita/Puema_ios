//
//  AskAnnieVM.swift
//  Pneuma
//
//  Created by MacBook Pro on 13/11/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class AskAnnieVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = AskAnnieTableDataSource()
    var apiServices: AskAnnieApiServices
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = AskAnnieApiServices()
        super.init()
    }
    
    func addQuestion(question : String, tag: Int, isFromVoice:Bool) {
        let model = AskAnnieModel(tag: tag, question: question, answer: "", isfrom: .Q, isFromVoice: isFromVoice)
        self.tableDataSource.listArray.append(model)
    }

    func addAnswer(answer : String, tag: Int, isFromVoice:Bool) {
        if answer == "BOOK" {
            let model = AskAnnieModel(tag: tag, question: "", answer: answer, isfrom: .BOOK, isFromVoice: isFromVoice)
            self.tableDataSource.listArray.append(model)
        }else {
            let model = AskAnnieModel(tag: tag, question: "", answer: answer, isfrom: .A, isFromVoice: isFromVoice)
            self.tableDataSource.listArray.append(model)
        }
//        if let model = self.tableDataSource.listArray.last {
//            model.answer = answer
//        }
    }
}


