//
//  NavigationProtocol.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit

protocol NavigationProtocol {
}

extension NavigationProtocol where Self: UIViewController {
    
    func setTransparentStatusBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    /*func setTwoButtonsNavigationBar(title: String? = nil, leftButtonImage: UIImage, leftButtonAction: Selector, rightButtonImage: UIImage, rightButtonAction: Selector) {
        self.navigationController?.navigationBar.removeSubviews()
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        self.setNavBar(isHidden: false)
        self.addTwoButtonsNavigationBar(title, leftButtonImage: leftButtonImage, leftButtonAction: leftButtonAction, rightButtonImage: rightButtonImage, rightButtonAction: rightButtonAction)
    }
    
    func addTwoButtonsNavigationBar(_ text: String?, leftButtonImage: UIImage, leftButtonAction: Selector, rightButtonImage: UIImage, rightButtonAction: Selector) {
        let navigationView = self.getCustomNavigationView(text ?? "")
        self.navigationItem.setHidesBackButton(true, animated: true)
        let customBackButton = self.self.getLeftBarButton(image: leftButtonImage, action: leftButtonAction)
        navigationView.addSubview(customBackButton)
        let rightButton = self.getRightBarButton(image: rightButtonImage, action: rightButtonAction)
        navigationView.addSubview(rightButton)
        
        let separator = self.getSeparator()
        navigationView.addSubview(separator)
        self.navigationController?.navigationBar.addSubview(navigationView)
    }
    
    func customizeNavigationBar(title: String? = nil, backButton: Bool, rightBarButtonImage: UIImage? = nil, rightBarButtonAction: Selector? = nil, customBackButton: UIButton? = nil) {
        self.navigationController?.navigationBar.removeSubviews()
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        self.setNavBar(isHidden: false)
        self.addCustomNavigationView(title, showBackButton: backButton, rightBarButtonImage: rightBarButtonImage, rightBarButtonAction: rightBarButtonAction, customBackButton: customBackButton)
    }
    
    private func addCustomNavigationView(_ text: String?, showBackButton: Bool, rightBarButtonImage: UIImage?, rightBarButtonAction: Selector?, customBackButton: UIButton?) {
        let navigationView = self.getCustomNavigationView(text ?? "")
        self.navigationItem.setHidesBackButton(true, animated: true)
        if showBackButton {
            var backButton = UIButton()
            if let customBackButton = customBackButton {
                backButton = customBackButton
            } else {
               backButton = self.getBackButton()
            }
            navigationView.addSubview(backButton)
        }
        if rightBarButtonImage != nil && rightBarButtonAction != nil {
            let rightButton = self.getRightBarButton(image: rightBarButtonImage!, action: rightBarButtonAction!)
            navigationView.addSubview(rightButton)
        }
        let separator = self.getSeparator()
        navigationView.addSubview(separator)
        self.navigationController?.navigationBar.addSubview(navigationView)
    }
    
    private func getCustomNavigationView(_ text: String) -> UIView {
        let font = AppFont.semiBold.fontWithSize(18)
        let width = text.width(withConstrainedHeight: 22, font: font)
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 35))
        titleLabel.textAlignment = .center
        titleLabel.font = font
        titleLabel.textColor = UIColor.white
        titleLabel.text = text
        let screenWidth = UIScreen.main.bounds.size.width
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        titleView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        titleView.addSubview(titleLabel)
        titleLabel.center = titleView.center
        return titleView
    }
    
    private func getBackButton() -> UIButton {
        let backButton = UIButton(frame: CGRect(x: 12, y: 0, width: 35, height: 35))
        backButton.roundCornerWithWidth()
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        backButton.setImageForAllStates(UIImage(named: "backButton")!)
        return backButton
    }
    
    private func getRightBarButton(image: UIImage, action: Selector) -> UIButton {
        let screenWidth = UIScreen.main.bounds.size.width
        let x = screenWidth - 47
        let backButton = UIButton(frame: CGRect(x: x, y: 0, width: 35, height: 35))
        backButton.roundCornerWithWidth()
        backButton.addTarget(self, action: action, for: .touchUpInside)
        backButton.setImageForAllStates(image)
        return backButton
    }
    
    private func getLeftBarButton(image: UIImage, action: Selector) -> UIButton {
        let leftButton = UIButton(frame: CGRect(x: 12, y: 0, width: 35, height: 35))
        leftButton.roundCornerWithWidth()
        leftButton.addTarget(self, action: action, for: .touchUpInside)
        leftButton.setImageForAllStates(image)
        return leftButton
    }
    
    private func getSeparator() -> UIView {
        let screenWidth = UIScreen.main.bounds.size.width
        let view = UIView(frame: CGRect(x: 10, y: 42, width: screenWidth - 20, height: 4))
        view.roundCornerWithHeight()
        view.backgroundColor = AppColor.themePink.getColor()
        return view
    }
    
    private func getCustomBarButton(title: String?, image: UIImage?, action: Selector) -> UIBarButtonItem {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        let size = image == nil ? 24: 34
        let button = UIButton(frame: CGRect(x: 10, y: 20, width: size, height: size))
        button.addTarget(self, action: action, for: .touchUpInside)
        if let title = title {
            button.titleLabel?.font = AppFont.regular.fontWithSize(13)
            button.setTitleColor(#colorLiteral(red: 0.1490000039, green: 0.1330000013, blue: 0.3840000033, alpha: 1), for: .normal)
            button.setTitle(title, for: .normal)
            button.frame.size.width = title.width(withConstrainedHeight: 24, font: AppFont.regular.fontWithSize(13))
        }else {
            button.setImage(image, for: .normal)
        }
        containerView.addSubview(button)
        button.center = containerView.center
        let barButton = UIBarButtonItem(customView: containerView)
        return barButton
    }
    
    func addRightBarButton(title: String?, image: UIImage?, selector: Selector) {
        self.navigationItem.rightBarButtonItem = self.getCustomBarButton(title: title, image: image, action: selector)
    }
    
    func setNavBar(isHidden: Bool) {
        if isHidden {
            UIApplication.shared.statusBarUIView?.backgroundColor = UIColor.clear
        }else {
            UIApplication.shared.statusBarUIView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }
        self.navigationController?.navigationBar.isHidden = isHidden
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }*/
    
}

fileprivate extension UIViewController {
    @objc func backButtonAction() {
        
        if self.children.count > 0 {
            for childVC in self.children {
                childVC.removeFromParent()
                childVC.view.removeFromSuperview()
            }
        }else {
            if self.navigationController?.popViewController(animated: true) == nil {
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
