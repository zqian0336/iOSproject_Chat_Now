//
//  UIView+.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/26/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import UIKit

extension UIView {
    
    func smoothRoundCorners(to radius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: radius
            ).cgPath
        
        layer.mask = maskLayer
    }
    
}
