//
//  NavBarSetUp.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import Foundation
import UIKit
class NavBarSetUp {
    static var navigationController:UINavigationController!
    static func setBackBtn(navigationItem:UINavigationItem , navController: UINavigationController) {
        navigationController = navController
        let backButton = UIBarButtonItem(title: "Custom", style: .plain, target: self, action: #selector(popScreen))
        backButton.image = UIImage(named: "previous") //Replaces title
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    @objc static func popScreen(){
        navigationController?.popViewController(animated: true)
    }
}
