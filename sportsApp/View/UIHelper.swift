//
//  UIHelper.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import Foundation
import UIKit

class UIHelper {
    static func removeExistingGradients(from view: UIView) {
            view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        }
    public static func addGradientSubViewToView(view:UIView) {
        view.layer.addSublayer(createGradientLayer(view))
    }
    public static func addGradientSubViewToCell(view:UIView) {
        view.layer.addSublayer(createGradientLayerForCell(view))
    }
    public static func addGradientSubView(view:UIView ,GardientColors:[CGColor] ) {
        view.layer.addSublayer(createGradientLayer(view: view, withColors: GardientColors))
    }
    public static func addGradientSubViewToView(view:UIView , at: UInt32) {
        view.layer.insertSublayer(createGradientLayer(view), at: at)
    }
    public static func addGradientSubViewToCell(view:UIView , at: UInt32) {
        let gradLayer = createGradientLayerForCell(view)
        gradLayer.frame = view.bounds
        view.layer.insertSublayer(gradLayer, at: at)
    }
    public static func addGradientSubViewToMatchCardCell(view:UIView , at: UInt32) {
        let gradLayer = createGradientLayerForMatchCardCell(view)
        gradLayer.frame = view.bounds
        view.layer.insertSublayer(gradLayer, at: at)
    }
    public static func addGradientSubView(view:UIView ,GardientColors:[CGColor]  , at: UInt32) {
        let gradLayer = createGradientLayer(view: view, withColors:GardientColors )
        gradLayer.frame = view.bounds
        view.layer.insertSublayer(gradLayer, at: at)
    }
    
    private static func createGradientLayer(_ view:UIView) -> CAGradientLayer{
        let gradLayer = CAGradientLayer()
        gradLayer.frame = view.bounds
        gradLayer.startPoint = CGPoint(x: 1.0, y: 0)
        gradLayer.colors = [UIColor(red: 1.0, green: 0.0, blue: 0.2, alpha: 1.0).cgColor,
                            UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0).cgColor]
//        gradLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradLayer.opacity = 0.15
        return gradLayer
    }
    private static func createGradientLayer(view:UIView ,withColors:[CGColor]) -> CAGradientLayer{
        let gradLayer = CAGradientLayer()
        gradLayer.frame = view.bounds 
        gradLayer.startPoint = CGPoint(x: 1.0, y: 0)
        gradLayer.colors = withColors
//        gradLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradLayer.opacity = 0.1
        return gradLayer
    }
    
    private static func createGradientLayerForCell(_ view:UIView) -> CAGradientLayer{
        let gradLayer   = CAGradientLayer()
        gradLayer.frame = view.bounds
        gradLayer.startPoint = CGPoint(x: 0, y: 0)
        gradLayer.colors = [UIColor(red: 0.5, green: 0.0, blue: 0.1, alpha: 1.0).cgColor,
                            UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0).cgColor]
        gradLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradLayer.opacity = 0.15
        return gradLayer
    }
    private static func createGradientLayerForMatchCardCell(_ view:UIView) -> CAGradientLayer{
        let gradLayer   = CAGradientLayer()
        gradLayer.frame = view.bounds
        gradLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradLayer.colors = [UIColor.red.cgColor,UIColor.black.cgColor,UIColor.black.cgColor,
                            UIColor.blue.cgColor]
        gradLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradLayer.opacity = 0.4
        return gradLayer
    }
}
