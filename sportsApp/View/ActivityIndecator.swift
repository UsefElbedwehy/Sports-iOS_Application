//
//  ActivityIndecator.swift
//  sportsApp
//
//  Created by Usef on 31/01/2025.
//

import Foundation
import UIKit
class ActivityIndecator {
    public static let instance = ActivityIndecator()
    var networkIndecator = UIActivityIndicatorView(style: .large)
    public func start(view:UIView){
        networkIndecator.center = view.center
        networkIndecator.startAnimating()
    }
    public func stop(){
        networkIndecator.stopAnimating()
    }
}
