//
//  PaymentMethodList+DataSource.swift
//  Pneuma
//
//  Created by Chitra on 15/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class PaymentMethodListDataSource: PaymentMethodListDataSourceModel, UITableViewDataSource {
    
    let cellId = "PaymentMethodCell"
    var editCallBack: ((Int)->())?
    var deleteCallBack: ((Int)->())?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PaymentMethodCell
        cell.delegate = self
        cell.setupContent(model: self.listArray[indexPath.row], index: indexPath.row)
        return cell
    }
    
}

//MARK:- PAYMENT ACTION DELEGATE
extension PaymentMethodListDataSource: PaymentActionDelegate {
    func didPressEdit(_ sender: PaymentMethodCell, index: Int) {
        print("edit:\(index)")
        self.editCallBack?(index)
    }
    
    func didPressDelete(_ sender: PaymentMethodCell, index: Int) {
        print("delete:\(index)")
        self.deleteCallBack?(index)
    }
}

//MARK:- UITABLEVIEW DELEGATE
extension PaymentMethodListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //set selected method as default
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
