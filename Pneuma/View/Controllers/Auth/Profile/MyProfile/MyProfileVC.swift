//
//  MyProfileVC.swift
//  Pneuma
//
//  Created by Chitra on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var customNavView: CustomNavigationView!
    
    //MARK:- VARIABLES
    var viewModel = MyProfileVM()
    let cellId = "CustomListCell"
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.customNavView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setValues()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableViewHeight.constant = self.tableView.contentSize.height
    }
    
    //MARK:- PRIVATE FUNCTIONS
    func registerCell() {
        self.tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        self.tableView.dataSource = self.viewModel.tableDataSource
        self.viewModel.handleSelectionCallback = { [weak self] (type) in
            self?.showChangeProfileDataVC(with: type)
        }
    }
    func updateData() {
        self.setValues()
    }
    private func setValues() {
        self.emailLabel.text = AppCache.shared.currentUser?.email
        self.nameLabel.text = AppCache.shared.currentUser?.name
    }
    
    private func showChangeProfileDataVC(with type: ProfileModelType) {
        let vc = UIStoryboard.loadChangeProfileDataVC()
        switch type {
        case .email:
            vc.changeMode = .email
        case .password:
            vc.changeMode = .password
        case .name:
            vc.changeMode = .name
        case .passportData:
            vc.changeMode = .passport
        case .phoneNumber:
            vc.changeMode = .phone
        default:
            return
        }
        vc.parentVC = self
        vc.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.async {
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
}

//MARK:- CUSTOM NAVIGATION VIEW DELEGATE
extension MyProfileVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressLeft button: UIButton) {
//        let vc = UIStoryboard.loadMenuVC()
//        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}
