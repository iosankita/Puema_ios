//
//  CustomNavigationView.swift
//  Pneuma
//
//  Created by Jatin on 26/02/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

protocol CustomNavigationViewDelegate: class {
    func view(_ view: CustomNavigationView, didPressLeft button: UIButton)
    func view(_ view: CustomNavigationView, didPressRight button: UIButton)
}

extension CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressLeft button: UIButton) {}
    func view(_ view: CustomNavigationView, didPressRight button: UIButton) {}
}

class CustomNavigationView: UIView {
    
    // MARK: - INSPECTABLE PROPERTIES
    @IBInspectable var title: String? {
        didSet {
            self.setupHeader()
        }
    }
    @IBInspectable var image: UIImage? {
        didSet {
            self.titleImageView.image = image
        }
    }
    @IBInspectable var leftButtonImage: UIImage? {
        didSet {
            self.leftButton.setImage(leftButtonImage, for: .normal)
        }
    }
    @IBInspectable var popOnLeftButtonClick: Bool = true
    
    @IBInspectable var hideLeftButton: Bool = false {
        didSet {
            if hideLeftButton {
                self.leftButton.removeFromSuperview()
            }
        }
    }
    
    @IBInspectable var rightButtonImage: UIImage? {
        didSet {
            self.rightButton.setTitle(nil, for: .normal)
            self.rightButton.setImage(rightButtonImage, for: .normal)
        }
    }
    @IBInspectable var rightButtonTitle: String? {
        didSet {
            self.rightButton.setImage(nil, for: .normal)
            self.rightButton.setTitle(rightButtonTitle, for: .normal)
        }
    }
    
    // MARK: - PROPERTIES
    var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "navigationBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "navigationAppLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.semiBold.fontWithSize(17)
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButtonWhite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var rightButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = AppFont.medium.fontWithSize(13)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var bottomMargin: CGFloat = -25
    private var buttonHeight: CGFloat = 25
    weak var delegate: CustomNavigationViewDelegate?

    // MARK: - INITIALIZER
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setupUI() {
        self.calculateFrame()
        self.setupBackgroundImage()
        self.setupLeftButton()
        self.setupRightButton()
        self.setupHeader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.roundCorners([.bottomLeft, .bottomRight], radius: 20)
        }
    }
    
    private func calculateFrame() {
        self.buttonHeight = self.height / 5
        self.bottomMargin = -(self.height / 5)
    }
    
    private func setupHeader() {
        if let title = self.title {
            self.titleLabel.text = title
            self.titleImageView.removeFromSuperview()
            self.setupTitleLabel()
        }else {
            self.titleLabel.removeFromSuperview()
            self.setupTitleImage()
        }
    }
    
    private func setupBackgroundImage() {
        
        self.addSubview(self.backgroundImageView)
        self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupLeftButton() {
        
        self.addSubview(self.leftButton)
        self.leftButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        self.leftButton.widthAnchor.constraint(equalToConstant: self.buttonHeight).isActive = true
        self.leftButton.heightAnchor.constraint(equalToConstant: self.buttonHeight).isActive = true
        self.leftButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.bottomMargin).isActive = true
        self.leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
    }
    
    @objc private func leftButtonAction(_ sender: UIButton) {
        if self.popOnLeftButtonClick {
            if let navigationVC = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                navigationVC.popViewController(animated: true)
            }
        }
        self.delegate?.view(self, didPressLeft: sender)
    }
    
    private func setupRightButton() {
        
        self.addSubview(self.rightButton)
        self.rightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        self.rightButton.widthAnchor.constraint(greaterThanOrEqualToConstant: self.buttonHeight).isActive = true
        self.rightButton.heightAnchor.constraint(equalToConstant: self.buttonHeight).isActive = true
        self.rightButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.bottomMargin).isActive = true
        self.rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
    }
    
    @objc private func rightButtonAction(_ sender: UIButton) {
        self.delegate?.view(self, didPressRight: sender)
    }
    
    private func setupTitleImage() {
        
        self.addSubview(self.titleImageView)
        self.titleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70).isActive = true
        self.titleImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70).isActive = true
        self.titleImageView.heightAnchor.constraint(equalToConstant: self.buttonHeight).isActive = true
        self.titleImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.bottomMargin).isActive = true
    }
    
    private func setupTitleLabel() {
        
        self.addSubview(self.titleLabel)
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: self.buttonHeight).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.bottomMargin).isActive = true
    }
}




























/*@IBDesignable
class Rainbow: UIView {
    
    @IBInspectable var innerCircleRadius:CGFloat = 80
    @IBInspectable var middleCircleRadius:CGFloat = 150
    @IBInspectable var outerCircleRadius:CGFloat = 215
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        // Add ARCs
//        self.addCirle(arcRadius: innerCircleRadius, capRadius: 20, color: self.firstColor)
//        self.addCirle(arcRadius: middleCircleRadius, capRadius: 20, color: self.secondColor)
//        self.addCirle(arcRadius: outerCircleRadius, capRadius: 20, color: self.thirdColor)
    }
    
    
}
*/

