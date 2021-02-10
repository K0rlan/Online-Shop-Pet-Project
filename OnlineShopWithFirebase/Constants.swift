//
//  Constants.swift
//  OnlineShopWithFirebase
//
//  Created by Korlan Omarova on 11.02.2021.
//

import UIKit

struct Constants {
    static let darkColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1)
    static let lightDarkColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1)
    static let tastyRoseColor = UIColor(red: 234/255, green: 31/255, blue: 77/255, alpha: 1)
    static let smokieRedColor = UIColor(red: 197/255, green: 21/255, blue: 46/255, alpha: 1)
    static let whiteMirrorColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
    
 }
extension UIButton {
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 8

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
    }
}
