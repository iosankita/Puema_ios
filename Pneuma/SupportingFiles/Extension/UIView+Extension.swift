//
//  UIView+Extension.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func roundCornerWithWidth() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
    func roundCornerWithHeight() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
    func addSubviewWithAnimation(_ view: UIView) {
        UIView.transition(with: self, duration: 0.40, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            self.addSubview(view)
        }) { (finish) in
            //
        }
    }
    
    func removeFromSuperViewWithAnimation() {
        if let superView = self.superview {
            UIView.transition(with: superView, duration: 0.40, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                self.removeFromSuperview()
            }) { (finish) in
                //
            }
        }
    }
    
    func addShadowWithRoundCorner(radius: CGFloat = 10, color: UIColor = .black, opacity: Float = 0.4, offSet: CGSize = .zero, shadowRadius: CGFloat = 10) {
        for layer in layer.sublayers ?? [] {
            if layer.isKind(of: CAShapeLayer.self) {
                layer.removeFromSuperlayer()
            }
            
        }
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        shadowLayer.fillColor = self.backgroundColor?.cgColor
        
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        
        shadowLayer.borderWidth = 2.0
        shadowLayer.borderColor = UIColor.red.cgColor
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func addBorderWithShadowAndCornerRadius(borderColor: UIColor) {
        layer.borderWidth = 1.5
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = 10.0
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.2
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    func performLeftToRightTransition() {
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.layer.add(transition, forKey: nil)
    }
    
    func performRightToLeftTransition() {
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.layer.add(transition, forKey: nil)
    }
    
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    
    func addBottomBorderWithColor(_ color: UIColor, width: CGFloat) {
        if self.layer.sublayers?.contains(where: {$0.name == "bottomBorder"}) ?? false {
            return
        }
        let border = CALayer()
        border.name = "bottomBorder"
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:self.frame.size.height - width, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }
    
    func removeBottomBoder() {
        if let bottomBorder = self.layer.sublayers?.filter({$0.name == "bottomBorder"}).first {
            bottomBorder.removeFromSuperlayer()
        }
    }
    
    func roundBottomCorners(radius: CGFloat = 25) {
        self.roundCorners([.bottomLeft, .bottomRight], radius: radius)
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, color: UIColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]? = [5, 4], radius: CGFloat, color: CGColor, width: CGFloat) -> CALayer {
        let borderLayer = CAShapeLayer()

        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.lineWidth = width
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

        layer.addSublayer(borderLayer)
        return borderLayer
    }
    
    func createPdfFromView(saveToDocumentsWithFileName fileName: String)
    {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, self.bounds, nil)
        UIGraphicsBeginPDFPage()

        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }

        self.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()

        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let documentsFileName = documentDirectories + "/" + fileName
            debugPrint(documentsFileName)
            pdfData.write(toFile: documentsFileName, atomically: true)
        }
    }

    func roundCorners(cornerRadius: Double, rectCorner: UIRectCorner, height:CGFloat, width:CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: height), byRoundingCorners: [rectCorner], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

    func setGradientBackground(colorTop:UIColor, colorBottom:UIColor,height:CGFloat,width:CGFloat) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)

        self.layer.insertSublayer(gradientLayer, at:0)
    }
}

