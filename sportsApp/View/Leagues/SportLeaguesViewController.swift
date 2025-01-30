//
//  SportLeaguesViewController.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import UIKit
import Kingfisher
let leaguesPlaceholderAddress = ["https://static.vecteezy.com/system/resources/previews/036/289/043/non_2x/football-premier-league-logo-design-vector.jpg"
    ,"https://img.freepik.com/free-vector/gradient-basketball-logo_52683-84313.jpg?semt=ais_hybrid"
    ,"https://www.shutterstock.com/image-vector/cricket-academy-sport-player-logo-600nw-2398285463.jpg"
    ,"https://c8.alamy.com/comp/2R2KBJ5/tennis-sport-tennis-club-logo-green-stamp-badge-tennis-ball-club-emblem-design-template-on-white-background-2R2KBJ5.jpg"]
protocol HomeProtocol {
    func renderDataToView(res:Leagues)
}
class SportLeaguesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , HomeProtocol{
    var leagueIndex = 0
    @IBOutlet weak var leaguesTableView: UITableView!
    var leaguesArray = [League]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let presenter = Presenter()
        presenter.attachToView(view: self)
        presenter.FetchLeaguesFromJson(leagueIndex)
        UIHelper.addGradientSubViewToView(view: view)
        leaguesTableView.delegate   = self
        leaguesTableView.dataSource = self
        NavBarSetUp.setBackBtn(navigationItem: navigationItem, navController: navigationController!)
    }
    func renderDataToView(res:Leagues) {
        leaguesArray = res.result!
        DispatchQueue.main.async {
            self.leaguesTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaguesTableView.dequeueReusableCell(withIdentifier: "SportLeaguescell", for: indexPath) as! SportLeagueTopCell
        if cell.layer.sublayers?.count == 2 {
            UIHelper.addGradientSubViewToCell(view: cell)
        }
        setTableCellsConfiguartions(cell)
        cell.leagueNameLabel.text = leaguesArray[indexPath.row].league_name
        let strUrl = leaguesArray[indexPath.row].league_logo ?? leaguesPlaceholderAddress[leagueIndex]
        
        let url = URL(string: strUrl)
        cell.leagueLogoImgView.kf.setImage(with: url)
        cell.leagueLogoImgView.layer.borderWidth = 3.0
        cell.leagueLogoImgView.layer.borderColor = UIColor.white.cgColor
        cell.leagueLogoImgView.layer.cornerRadius = 35
        cell.leagueLogoImgView.contentMode = .scaleAspectFit
        return cell
    }
    
    func setTableCellsConfiguartions(_ cell: UITableViewCell){
        cell.contentView.layer.cornerRadius = 20.0
        cell.layer.cornerRadius = 20.0
        cell.layer.shadowRadius = 6.0
        cell.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowColor = UIColor.black.cgColor
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDCVC = self.storyboard?.instantiateViewController(identifier: "leagueDetailsCVC") as! LeagueDetailsCollectionViewController
        leagueDCVC.leagueIndex = leagueIndex
        print("\(leaguesArray[indexPath.row].league_key ?? 12345678)")
        self.navigationController?.pushViewController(leagueDCVC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
