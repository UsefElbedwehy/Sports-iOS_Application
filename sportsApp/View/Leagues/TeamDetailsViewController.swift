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
    override func viewDidLoad() {
        super.viewDidLoad()
        teamTableView.delegate   = self
        teamTableView.dataSource = self
        UIHelper.addGradientSubViewToView(view: view)
        NavBarSetUp.setBackBtn(navigationItem: navigationItem, navController: navigationController!)
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
        let playerCell = teamTableView.dequeueReusableCell(withIdentifier: "teamCell") as! PlayersOfTeamTableViewCell
        switch indexPath.section {
        case 0:
            playerCell.playerNameLB.text = playersArray[indexPath.row].player_name
        default:
            configurePlayerCell(playerCell: playerCell, indexPath: indexPath)
        }
        return playerCell
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
//    func renderPlayersToView(res: Players) {
//        playersArray = res
//        DispatchQueue.main.async {
//            
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
