//
//  Gradient.swift
//  User App
//
//  Created by Anuj Doshi on 30/01/20.
//  Copyright © 2020 Anuj Doshi. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func setGradientColor(colorOne:UIColor,colorTwo:UIColor){
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.colors = [colorOne.cgColor,colorTwo.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
}
