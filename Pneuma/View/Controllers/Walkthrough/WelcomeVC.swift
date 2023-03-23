//
//  WelcomeVC.swift
//  Pneuma
//
//  Created by Chitra on 26/02/21.
//  Copyright © 2021 Chitra. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    var welcomePageVC: WelcomePageVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let image = UIImage.outlinedEllipse(size: CGSize(width: 7.0, height: 7.0), color: AppColor.themeViolet.getColor())
        self.pageControl.pageIndicatorTintColor = UIColor.init(patternImage: image!)
        self.pageControl.currentPageIndicatorTintColor = AppColor.themeViolet.getColor()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageVC = destination as? WelcomePageVC {
            welcomePageVC = pageVC
            welcomePageVC?.walkthroughDelegate = self
            pageControl.numberOfPages = welcomePageVC?.walkthroughArray.count ?? 0
        }
    }

    func gotoLoginVC() {
        AppCache.shared.isWalkthroughShown = true
        let loginVC = UIStoryboard.loadLoginVC()
        let navigationController = UINavigationController.init(rootViewController: loginVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.delegate?.window??.rootViewController = navigationController
    }
    
    @IBAction func skipButtonAction(_ sender: Any) {
        gotoLoginVC()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        guard let vc = welcomePageVC else { return }
        switch vc.currentIndex {
        case 0...(vc.walkthroughArray.count-2)://Walktrhough array count must be minimum 2
            welcomePageVC?.forwardPage()
        case (vc.walkthroughArray.count-1):
            skipButtonAction(self)
        default:
            break
        }
    }
    
   
    
}

//MARK:- Walkthrough Page View Controller Delegate
extension WelcomeVC: WalkthroughPageVCDelegate {
    func didUpdatePageIndex(currentIndex: Int) {
        self.pageControl.currentPage = currentIndex
        if currentIndex == 3{
            nextButton.setTitle("DONE", for: .normal)
        }else{
            nextButton.setTitle("NEXT", for: .normal)
        }
    }
}
