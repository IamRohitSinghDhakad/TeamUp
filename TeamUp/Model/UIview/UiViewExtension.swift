//
//  UiViewExtension.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import Foundation
import UIKit

extension UIView {
    func setCornerRadiousAndBorder(_ color: UIColor, borderWidth: CGFloat) {
        self.layer.cornerRadius = 5
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
    
    func setCornerRadiousAndBorder(_ color: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
    
    func circleView(_ color: UIColor, borderWidth: CGFloat) {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
    
    func setShadowOnView(_ shadowColor: UIColor) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func setShadowOnViewWithRadious(_ shadowColor: UIColor, shadowRadius: CGFloat) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.cornerRadius = shadowRadius
        self.clipsToBounds = false
    }
    
    func setShadowOnViewWithRadious(_ shadowColor: UIColor, shadowRadius: CGFloat, shadowOffset: CGSize) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
    }
}
