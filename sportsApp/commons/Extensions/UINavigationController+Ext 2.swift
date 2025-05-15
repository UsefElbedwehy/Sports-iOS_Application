//
//  NavBarSetUp.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import UIKit

extension UINavigationController {

    func setCustomBackButton(for navigationItem: UINavigationItem, title: String = "Back", imageName: String = "previous") {
        let backButton = UIBarButtonItem(
            title: title,
            style: .plain,
            target: self,
            action: #selector(handleBackButton)
        )
        backButton.image = UIImage(named: imageName)
        navigationItem.leftBarButtonItem = backButton
    }

    @objc private func handleBackButton() {
        self.popViewController(animated: true)
    }
}
