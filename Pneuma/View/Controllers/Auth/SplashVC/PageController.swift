//
//  PageController.swift
//  Pneuma
//
//  Created by MacBook Pro on 31/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class PageController: UIPageViewController {

    var pageControl: UIPageControl!
    lazy var pages: [UIViewController] = {
        return [
        
        self.getViewController(withIndex: 0),
        self.getViewController(withIndex: 1),
        self.getViewController(withIndex: 2)
            
        ]
    } ()
    
    fileprivate func getViewController(withIndex index: Int) -> UIViewController {
        let controller = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "PageChildController") as! PageChildController
        controller.index = index
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        configurePageControl()
        if let firstPage = self.pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func configurePageControl() {
        let parent = self.parent as! SplashVC
        self.pageControl = parent.pageControl
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = .systemOrange
        self.pageControl.pageIndicatorTintColor = .systemGray
        self.pageControl.currentPageIndicatorTintColor = .systemOrange
    }
}

extension PageController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else {
            return nil
        }
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard pages.count > previousIndex else {
            return nil
        }
        return pages[previousIndex]
    }
}

extension PageController : UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = self.viewControllers![0]
        self.pageControl.currentPage = pages.firstIndex(of: pageContentViewController)!
    }
}


