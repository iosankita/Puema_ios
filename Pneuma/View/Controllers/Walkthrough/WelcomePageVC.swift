//
//  WelcomePageVC.swift
//  Pneuma
//
//  Created by Chitra on 26/02/21.
//  Copyright © 2021 Chitra. All rights reserved.
//

import UIKit
import GLWalkthrough
protocol WalkthroughPageVCDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class WelcomePageVC: UIPageViewController {
    
    var coachMarker:GLWalkThrough!
    
    struct WalkthroughModel {
        var image: String
        var text: String
        
        init(image: String, text: String) {
            self.image = image
            self.text = text
        }
    }
    
    //MARK:- VARIABLES
    var walkthroughArray = [WalkthroughModel(image: "walkthrough1", text: "Reset Ticket Booking, Hotel Booking and Taxi All-in-one Application"),
                            WalkthroughModel(image: "walkthrough2", text: "ANNIE is your Voice Assistant. Activate ANNIE by Taping one button."),
                            WalkthroughModel(image: "walkthrough3", text: "ANNIE is your Voice Assistant. Activate ANNIE by Taping one button."),
                            WalkthroughModel(image: "walkthrough4", text: "Have some free time while traveling? Plan it Profitably with City Discover")]
    var currentIndex = 0
    weak var walkthroughDelegate: WalkthroughPageVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coachMarker = GLWalkThrough()
        coachMarker.dataSource = self
        coachMarker.delegate = self
        coachMarker.show()
        // Set the data source and the delegate to itself
        dataSource = self
        delegate = self
        
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: false, completion: nil)
        }
    }
    @IBAction func showPreview(_ sender: UIBarButtonItem) {
        coachMarker = GLWalkThrough()
        coachMarker.dataSource = self
        coachMarker.delegate = self
        coachMarker.show()
    }
}
//MARK:- PAGE VIEW CONTROLLER DATASOURCE METHOD
extension WelcomePageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WelcomeContentVC).index
        index -= 1
        if index >= 0 {
            currentIndex = index
            return contentViewController(at: index)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WelcomeContentVC).index
        index += 1
        if index <= (walkthroughArray.count-1) {
            currentIndex = index
            return contentViewController(at: index)
        } else {
            return nil
        }
        
    }
    
    func contentViewController(at index : Int) -> WelcomeContentVC? {
        if index < 0 || index >= walkthroughArray.count{
            return nil
        }
        
        //Create a new view controller and pass suitable data
        let pageVC = UIStoryboard.loadWelcomeContentVC()
        pageVC.imageFile = walkthroughArray[index].image
        pageVC.heading = walkthroughArray[index].text
        pageVC.index = index
        return pageVC
    }
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            walkthroughDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
        }
    }
    
    private func gotoLoginVC() {
        AppCache.shared.isWalkthroughShown = true
        let loginVC = UIStoryboard.loadLoginVC()
        let navigationController = UINavigationController.init(rootViewController: loginVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.delegate?.window??.rootViewController = navigationController
    }
}

// MARK: - Page View Controller delegate
extension WelcomePageVC: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WelcomeContentVC {
                currentIndex = contentViewController.index
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
    
}

// MARk: --
extension WelcomePageVC: GLWalkThroughDelegate {
    func didSelectNextAtIndex(index: Int) {
        if index == 5 {
            coachMarker.dismiss()
            let alert = UIAlertController(title: "Walkthrough Completed", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func didSelectSkip(index: Int) {
        coachMarker.dismiss()
    }
    
    
}
extension WelcomePageVC: GLWalkThroughDataSource {
    func getTabbarFrame(index:Int) -> CGRect? {
        if let bar = self.tabBarController?.tabBar.subviews {
            var idx = 0
            var frame:CGRect!
            for view in bar {
                if view.isKind(of: NSClassFromString("UITabBarButton")!) {
                    print(view.description)
                    if idx == index {
                        frame =  view.frame
                    }
                    idx += 1
                }
            }
            return frame
        }
        return nil
    }
    
    func numberOfItems() -> Int {
        return 7
    }
    
    func configForItemAtIndex(index: Int) -> GLWalkThroughConfig {
        let tabbarPadding:CGFloat = Helper.shared.hasTopNotch ? 88 : 50
        let overlaySize:CGFloat = Helper.shared.hasTopNotch ? 60 : 50
        let leftPadding:CGFloat = Helper.shared.hasTopNotch ? 10 : 5
        switch index {
        case 0:
            var config = GLWalkThroughConfig()
            config.title = "Home Screen"
            config.subtitle = "Here you can explore Services, Articles, plans"
            config.frameOverWindow = CGRect(x: 10, y: 37, width: overlaySize, height: overlaySize)
            config.position = .topLeft
            return config
        case 1:
            var config = GLWalkThroughConfig()
            config.title = "Restart"
            config.subtitle = "Restart walkthrough sample"
            config.frameOverWindow = CGRect(x: view.frame.size.width - 65, y: 45, width: overlaySize, height: overlaySize)
            config.position = .topRight
            return config
        case 2:
            guard let frame = getTabbarFrame(index: 0) else {
                return GLWalkThroughConfig()
            }
            var config = GLWalkThroughConfig()
            config.title = "Home Screen"
            config.subtitle = "Here you can explore Services, Articles, plans"
            config.frameOverWindow = CGRect(x: frame.origin.x + leftPadding, y: view.frame.size.height - tabbarPadding, width: overlaySize, height: overlaySize)
            
            return config
        case 3:
            guard let frame = getTabbarFrame(index: 1) else {
                return GLWalkThroughConfig()
            }
            var config = GLWalkThroughConfig()
            config.title = "Share"
            config.subtitle = "Consists Ongoing Expert chats, Plans, Requests"
            config.frameOverWindow = CGRect(x: frame.origin.x + leftPadding, y: view.frame.size.height - tabbarPadding, width: overlaySize, height: overlaySize)
            config.position = .bottomLeft
            return config
        case 4:
            guard let frame = getTabbarFrame(index: 2) else {
                return GLWalkThroughConfig()
            }
            var config = GLWalkThroughConfig()
            config.title = "General Queries"
            config.subtitle = "Ask your question in a General Forum"
            config.frameOverWindow = CGRect(x: frame.origin.x + leftPadding, y: view.frame.size.height - tabbarPadding, width: overlaySize, height: overlaySize)
            config.position = .bottomCenter
            return config
            
            
        case 5:
            guard let frame = getTabbarFrame(index: 3) else {
                return GLWalkThroughConfig()
            }
            var config = GLWalkThroughConfig()
            config.title = "My Profile"
            config.subtitle = "Your Account details, Wallets, Settings"
            config.frameOverWindow = CGRect(x: frame.origin.x + leftPadding, y: view.frame.size.height - tabbarPadding, width: overlaySize, height: overlaySize)
            config.position = .bottomRight
            return config
        case 6:
            guard let frame = getTabbarFrame(index: 4) else {
                return GLWalkThroughConfig()
            }
            var config = GLWalkThroughConfig()
            config.title = "ChatBot"
            config.subtitle = "Ask a Service, Query, Plan to Bot"
            config.nextBtnTitle = "Ask a Query"
            
            config.frameOverWindow = CGRect(x: frame.origin.x + leftPadding, y: view.frame.size.height - tabbarPadding, width: overlaySize, height: overlaySize)
            config.position = .bottomRight
            return config
        case 7:
            
            var config = GLWalkThroughConfig()
            config.title = "ChatBot"
            config.subtitle = "Ask a Service, Query, Plan to Bot"
            config.nextBtnTitle = "Ask a Query"
            
//            config.frameOverWindow = CGRect
            config.position = .bottomCenter
            return config
        default:
            return GLWalkThroughConfig()
        }
    }
    
    
}


struct Helper {
    static var shared = Helper()
    
    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}
