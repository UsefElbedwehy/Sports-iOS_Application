//
//  TeamDetailsViewController.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource /*, TeamProtocol*/ {

    @IBOutlet weak var teamTableView: UITableView!
    var playersArray = [Players]()
    var teamID = 0
    var teamLogo = ""
    var teamName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        teamTableView.delegate   = self
        teamTableView.dataSource = self
        UIHelper.addGradientSubViewToView(view: view)
        navigationController?.setCustomBackButton(for: navigationItem)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return playersArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let teamCardCell = teamTableView.dequeueReusableCell(withIdentifier: "teamDetailsCell") as! TeamCellInTeamDetails
            teamCardCell.teamNameLB.text = teamName
            setTeamLogo(teamCell: teamCardCell)
            return teamCardCell
            
        default:
            let playerCell = teamTableView.dequeueReusableCell(withIdentifier: "teamCell") as! PlayersOfTeamTableViewCell
            configurePlayerCell(playerCell: playerCell, indexPath: indexPath)
            return playerCell
        }
        
    }
    func configurePlayerCell(playerCell: PlayersOfTeamTableViewCell, indexPath: IndexPath){
        playerCell.playerNameLB.text = playersArray[indexPath.row].player_name
        playerCell.playerNumberLB.text = playersArray[indexPath.row].player_number
        playerCell.playerPositionLB.text = playersArray[indexPath.row].player_type
        setPlayerImage(playerCell: playerCell, indexPath: indexPath)
        setPlayerCellGradient(playerCell:playerCell)
        playerCell.playerCardView.frame = view.bounds
        playerCell.layer.cornerRadius = 50.0
    }
    func setPlayerCellGradient(playerCell: PlayersOfTeamTableViewCell) {
        UIHelper.removeExistingGradients(from: playerCell.playerCardView)
        UIHelper.addGradientSubViewToPlayerCell(view: playerCell.playerCardView, at: 0)
    }
    func setPlayerImage(playerCell: PlayersOfTeamTableViewCell , indexPath: IndexPath) {
        if let playerUrl = URL(string: playersArray[indexPath.row].player_image ?? "https://www.plasticoncomposites.com/de/img/team-placeholder.png") {
            let placeholder = UIImage(named: "team-placeholder")  // Ensure you add this image to Assets
            playerCell.playerImgView.kf.setImage(with: playerUrl, placeholder: placeholder)
        } else {
            playerCell.playerImgView.image = UIImage(named: "team-placeholder")
        }
        playerCell.playerImgView.layer.cornerRadius = 130/2
        playerCell.playerImgView.layer.borderWidth = 3.0
        playerCell.playerImgView.layer.borderColor = UIColor.blue.cgColor
    }
    func setTeamLogo(teamCell: TeamCellInTeamDetails) {
        if let teamLogoUrl = URL(string: teamLogo) {
            let placeholder = UIImage(named: "team-placeholder")
            teamCell.teamLogoImgView.kf.setImage(with: teamLogoUrl, placeholder: placeholder)
        } else {
            teamCell.teamLogoImgView.image = UIImage(named: "team-placeholder")
        }
        teamCell.teamLogoImgView.layer.cornerRadius = 20
    }


}
