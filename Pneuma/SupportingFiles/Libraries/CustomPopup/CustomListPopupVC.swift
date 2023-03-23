//
//  CustomListPopupVC.swift
//  MrNiceGuy-Customer
//
//  Created by Chitra on 31/03/20.
//  Copyright © 2021 Dharmender. All rights reserved.
//

import UIKit

class PopupListModel {
    var title: String?
    var selected = false
    var apiValue: Int?
    var id: String?
    
    init(title: String?, selected: Bool = false, apiValue: Int? = nil, id: String? = nil) {
        self.title = title
        self.selected = selected
        self.apiValue = apiValue
        self.id = id
    }
}

class CustomListPopupVC: UIViewController {

     // MARK: - IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popupHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var crossButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = titleString
        self.optionArray = (array)
        self.registerCell()
        self.tableView.reloadData()
        self.adjustPopupHeight()
    }

    // MARK: - VARIABLES
    private let cellIdentifier = "CustomListPopupCell"
    var optionArray = [PopupListModel]()
    var callBack: ((_ model: PopupListModel) -> ())?
    var titleString = ""
    var array = [PopupListModel]()
        
    // MARK: - CLASS LIFE CYCLE
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, touch.view != popupView {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func adjustPopupHeight() {
        let height = self.tableView.contentSize.height + 59
        if height < (UIScreen.main.bounds.height - 80) {
            self.popupHeightConstraint.constant = height
            self.tableView.isScrollEnabled = false
        }else {
            self.popupHeightConstraint.constant = (UIScreen.main.bounds.height - 80)
            self.tableView.isScrollEnabled = true
        }
    }
    
    // MARK: - HELPER FUNCTIONS
    func updateData(with array: [PopupListModel]) {
        self.optionArray = (array)
        self.tableView.reloadData()
    }
    
    private func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    @IBAction func crossButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CustomListPopupVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomListPopupCell
        cell?.titleLabel.text = (optionArray[indexPath.row].title ?? "").capitalizingFirstLetter()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.callBack?(optionArray[indexPath.row])
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
