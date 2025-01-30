//
//  LeaguesCollectionViewCell.swift
//  sportsApp
//
//  Created by Usef on 27/01/2025.
//

import UIKit

class LeaguesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var viewLayer: UIView!
    override func layoutSubviews() {
        super.layoutSubviews()
        viewLayer.layer.sublayers?.forEach { sublayer in
            if let gradientLayer = sublayer as? CAGradientLayer {
                gradientLayer.frame = viewLayer.bounds
            }
        }
    }
}
