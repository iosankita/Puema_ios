//
//  InitialQuestionsVC+TableDelegate.swift
//  Pneuma
//
//  Created by Chitra on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
 
extension InitialQuestionsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectItem(at: indexPath)
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let question = self.viewModel.tableDataSource.listArray[indexPath.row].question
//        let height = question.height(constraintedWidth: self.view.frame.size.width - 50, font: UIFont(name: "Poppins-SemiBold", size: 16.0) ?? .systemFont(ofSize: 16.0)) + 20 + 8 + 45
//        return height
//    }
}
