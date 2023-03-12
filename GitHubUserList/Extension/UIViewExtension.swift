//
//  UIViewExtension.swift
//  GitHubUserList
//
//  Created by Irvin Liao on 2023/3/12.
//

import Foundation
import UIKit

extension UIView {
    
    func dropShadow(color: UIColor = .black, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / UIScreen.main.scale
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func rounded() {
        layer.cornerRadius = frame.height / 2
    }
}
