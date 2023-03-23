//
//  InitialQuestionsVC+TableDataSource.swift
//  Pneuma
//
//  Created by Chitra on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class QuestionsTableDataSource: QuestionsTableDataSourceModel, UITableViewDataSource {
    
    // MARK: - VARIABLES
    private let cellIdentifier = "QuestionnaireTVC"
    
    // MARK: - TABLE DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! QuestionnaireTVC
        cell.setupCell(model: self.listArray[indexPath.row], index: indexPath.row)
        return cell
    }
}
