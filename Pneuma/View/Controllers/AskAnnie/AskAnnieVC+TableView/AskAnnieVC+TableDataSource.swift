//
//  AskAnnieVC+TableDataSource.swift
//  Pneuma
//
//  Created by MacBook Pro on 13/11/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class AskAnnieTableDataSource: AskAnnieDataSourceModel, UITableViewDataSource {
    
    // MARK: - VARIABLES
    let cellIdentifier = "userCell"
    let cellIdentifier2 = "annieCell"
    
    // MARK: - TABLE DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.listArray[indexPath.row]
        if model.isFrom == .Q {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserCell
            cell.lblUserVoice.text = model.question
            cell.lblUserVoice.textColor = .black
            cell.viewBG.backgroundColor = .white
            cell.viewBG.layer.cornerRadius = 5.0
            cell.selectionStyle = .none
            //cell.viewBG.roundCorners(cornerRadius: 5.0, rectCorner: [.bottomLeft,.bottomRight,.topLeft], height: cell.viewBG.bounds.height, width: cell.viewBG.bounds.width)
            return cell
        }else if model.isFrom == .A{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2, for: indexPath) as! AnnieCell
            cell.viewBG.backgroundColor = .white
            cell.lblAnnieVoice.textColor = .black
            cell.viewBG.layer.cornerRadius = 5.0
            //cell.viewBG.roundCorners(cornerRadius: 5.0, rectCorner: [.bottomLeft,.bottomRight,.topRight], height: cell.viewBG.bounds.height, width: cell.viewBG.bounds.width)
            cell.lblAnnieVoice.text = model.answer
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2, for: indexPath) as! AnnieCell
            cell.viewBG.backgroundColor = .purpleBlue
            cell.viewBG.layer.cornerRadius = 5.0
            //cell.viewBG.roundCorners(cornerRadius: 5.0, rectCorner: [.bottomLeft,.bottomRight,.topRight], height: cell.viewBG.bounds.height, width: cell.viewBG.bounds.width)
            cell.lblAnnieVoice.text = model.answer
            cell.lblAnnieVoice.textColor = .white
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
