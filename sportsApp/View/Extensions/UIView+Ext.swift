//
//  ActivityIndecator.swift
//  sportsApp
//
//  Created by Usef on 31/01/2025.
//

import Foundation
import UIKit

import UIKit

extension UIView {
    private static let loadingViewTag = 2482915825

    func startActivityIndicator(style: UIActivityIndicatorView.Style = .large) {
        // Prevent adding multiple indicators
        if viewWithTag(Self.loadingViewTag) != nil { return }

        let loading = UIActivityIndicatorView(style: style)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.hidesWhenStopped = true
        loading.tag = Self.loadingViewTag
        loading.startAnimating()

        addSubview(loading)

        // Center it within the view
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func stopActivityIndicator() {
        DispatchQueue.main.async {
            if let loading = self.viewWithTag(Self.loadingViewTag) as? UIActivityIndicatorView {
                loading.stopAnimating()
                loading.removeFromSuperview()
            }
        }
    }
}

