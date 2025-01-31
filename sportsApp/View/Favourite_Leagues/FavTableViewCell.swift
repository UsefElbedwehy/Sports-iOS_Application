//
//  FavTableViewCell.swift
//  sportsApp
//
//  Created by Usef on 31/01/2025.
//

import UIKit

class FavTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var favImgView: UIImageView!
    
    @IBOutlet weak var favNameLB: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = .clear
        favImgView.layer.cornerRadius = favImgView.frame.width / 2
        favImgView.clipsToBounds = true
        favImgView.layer.borderWidth = 3
        favImgView.layer.borderColor = UIColor.white.cgColor
        self.favNameLB.textColor = UIColor.white
    }

}
