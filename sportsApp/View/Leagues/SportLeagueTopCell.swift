//
//  SportLeagueTopCell.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import UIKit

class SportLeagueTopCell: UITableViewCell {

    @IBOutlet weak var leagueLogoImgView: UIImageView!
    
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        setTableCellsConfiguartions()
        self.leagueLogoImgView.layer.borderWidth = 3.0
        self.leagueLogoImgView.layer.borderColor = UIColor.white.cgColor
        self.leagueLogoImgView.layer.cornerRadius = 35
        self.leagueLogoImgView.contentMode = .scaleAspectFit
    }
    func setTableCellsConfiguartions(){
        self.contentView.layer.cornerRadius = 20.0
        self.layer.cornerRadius = 20.0
        self.layer.shadowRadius = 6.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
