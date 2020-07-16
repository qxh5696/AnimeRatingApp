//
//  UIViewExtensions.swift
//  AnimeBrowsingApp
//
//  Created by qadir haqq on 7/1/20.
//  Copyright © 2020 qadir haqq. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func pin(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true        
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.23
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    func addDarkenedEffect() {
        let darkView = UIView.init(frame: self.frame)
        let darkLayer = darkView.layer
        darkLayer.backgroundColor = UIColor.black.cgColor
        darkLayer.opacity = 0.25
        self.addSubview(darkView)
    }
    
    
}
