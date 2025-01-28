//
//  UIHelper.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import Foundation
import UIKit

class UIHelper {
    static func createGradientLayer(_ view:UIView) -> CAGradientLayer{
        let gradLayer = CAGradientLayer()
        gradLayer.frame = view.frame
        gradLayer.startPoint = CGPoint(x: 1.0, y: 0)
        gradLayer.colors = [UIColor(red: 1.0, green: 0.0, blue: 0.2, alpha: 1.0).cgColor,
                            UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0).cgColor]
//        gradLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradLayer.opacity = 0.15
        return gradLayer
    }
    static func createGradientLayerBlack(_ view:UIView) -> CAGradientLayer{
        let gradLayer = CAGradientLayer()
        gradLayer.frame = view.frame
        gradLayer.startPoint = CGPoint(x: 1.0, y: 0)
        gradLayer.colors = [UIColor.white.cgColor,
                            UIColor.black.cgColor]
//        gradLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradLayer.opacity = 0.1
        return gradLayer
    }
    static func createGradientLayerForCell(_ view:UIView) -> CAGradientLayer{
        let gradLayer = CAGradientLayer()
        gradLayer.frame = view.frame
        gradLayer.startPoint = CGPoint(x: 0, y: 0)
        gradLayer.colors = [UIColor(red: 0.5, green: 0.0, blue: 0.1, alpha: 1.0).cgColor,
                            UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0).cgColor]
//        gradLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradLayer.opacity = 0.1
        return gradLayer
    }
}
