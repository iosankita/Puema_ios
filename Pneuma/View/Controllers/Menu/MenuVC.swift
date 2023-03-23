//
//  MenuVC.swift
//  Pneuma
//
//  Created by Chitra on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, AlertProtocol {
    
    //MARK:- IBOUTLETS
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var parentView: UIView!
    
    //MARK:- VARIABLES
    var viewModel = MenuVM()
    var logoutViewModel = LogoutVM()
    var menuSelected = [[MenuModel]]()
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self.viewModel.tableDataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showData()
        self.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, touch.view == self.parentView {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK:- IBACTIONS
    @IBAction func logoutAction(_ sender: Any) {
        self.showAlertWithTwoButton(message: LocalizedStringEnum.confirmLogout.localized, firstButtonTitle: LocalizedStringEnum.yes.localized, secondButtonTitle: LocalizedStringEnum.no.localized, firstButtonCompletion: { (action) in
            self.logout()
        }) { (action) in
            
        }
    }
    
    @IBAction func travelBuddyAction(_ sender: Any) {
        self.gotoMyTravelBuddies()
    }
    
    //MARK:- PRIVATE FUNCTIONS
    private func logout() {
        CustomLoader.shared.show()
        self.logoutViewModel.logout { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(_):
                //Handle UI or navigation
                self.showAlertWithText(self.logoutViewModel.responseModel?.message ?? "", buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
                    AppCache.shared.removeAllUserDefaults()
                    self.gotoLoginVC()
                }
                return
            case .failure(let error):
                self.showAlertWithText(error.message)
            }
        }
    }
    
    private func showData() {
//        self.userImageView.image = UIImage(named: "person")
        self.userName.text = AppCache.shared.currentUser?.name
        self.userEmail.text = AppCache.shared.currentUser?.email
    }
    func gotoLoginVC() {
        AppCache.shared.isWalkthroughShown = true
        let loginVC = UIStoryboard.loadLoginVC()
        let navigationController = UINavigationController.init(rootViewController: loginVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.delegate?.window??.rootViewController = navigationController
    }
}
