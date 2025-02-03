//
//  TeamCellInTeamDetails.swift
//  sportsApp
//
//  Created by Usef on 02/02/2025.
//

import UIKit

class TeamCellInTeamDetails: UITableViewCell {

    @IBOutlet weak var teamLogoImgView: UIImageView!
    
    @IBOutlet weak var teamNameLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
