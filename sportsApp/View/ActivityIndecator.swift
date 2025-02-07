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
    public func start(at:UIViewController){
        networkIndecator.center = at.view.center
        networkIndecator.color = UIColor.white
        at.view.addSubview(networkIndecator)
        networkIndecator.startAnimating()
    }
    public func stop(){
        DispatchQueue.main.async {
            self.networkIndecator.stopAnimating()
        }
    }
}
