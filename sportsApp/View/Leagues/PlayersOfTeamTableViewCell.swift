//
//  PlayersOfTeamTableViewCell.swift
//  sportsApp
//
//  Created by Usef on 30/01/2025.
//

import UIKit

class PlayersOfTeamTableViewCell: UITableViewCell {
    @IBOutlet weak var playerCardView: UIView!
    
    @IBOutlet weak var playerImgView: UIImageView!
    
    @IBOutlet weak var playerNameLB: UILabel!
    
    @IBOutlet weak var playerNumberLB: UILabel!
    
    @IBOutlet weak var playerPositionLB: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
