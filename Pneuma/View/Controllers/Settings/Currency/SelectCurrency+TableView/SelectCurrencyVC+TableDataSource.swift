//
//  SelectCurrencyVC+TableDataSource.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class SelectCurrencyDataSource: CurrencyDataSourceModel, UITableViewDataSource {
    
    //MARK:- VARIABLES
    let cellId = "CustomListCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomListCell
        cell.title.text = self.listArray[indexPath.row].title
        cell.prepareUI(type: .radioButton)
        return cell
    }
    
    
    
}
