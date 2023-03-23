//
//  SplashVC.swift
//  Pneuma
//
//  Created by MacBook Pro on 31/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class SplashVC: UIViewController, AlertProtocol {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var nextButton: UIButton!
    var pageController : PageController!
    var viewModel = InitialQuestionsVM()
    
    @IBAction func nextAction(_ sender: Any) {
        if(pageControl.currentPage + 1 != pageControl.numberOfPages) {
            let nextPage = pageController.pages[pageControl.currentPage + 1]
            self.pageController.setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)
            self.pageControl.currentPage = pageControl.currentPage + 1
        } else {
            self.viewModel.getAnswerList { result in
                switch result {
                case .success(_):
                    let response = self.viewModel.getAnswersResponseModel
                    if let arr = response?.data {
                        if arr.isEmpty {
                            let vc = UIStoryboard.loadInitialQuestionsVC()
                            self.navigationController?.pushViewController(vc, animated: true)
                            break
                        }
                        for element in arr {
                            if element.answer == "" {
                                let vc = UIStoryboard.loadInitialQuestionsVC()
                                self.navigationController?.pushViewController(vc, animated: true)
                                break
                            }
                        }
                        AppCache.shared.isInitialQuestionAnswered = true
                        let vc = UIStoryboard.loadHomeVC()
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    }
                case .failure(let error):
                    print(error)
                    self.showAlertWithText("Please try again after some time")
                    break
                }
            }

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureWalkThrough()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    func configureWalkThrough () {
        pageController = PageController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        addChild(pageController)
        pageController.view.frame = self.containerView.bounds
        self.containerView.addSubview(pageController.view)
        pageController.didMove(toParent: self)
        
    }
}
