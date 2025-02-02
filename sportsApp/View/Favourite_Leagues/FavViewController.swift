//
//  FavViewController.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import UIKit
import Kingfisher
protocol FavLeagueProtocol {
    func renderFavLeaguesToTableView(res: [League])
}


class FavViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , FavLeagueProtocol{
    
    var favLeagues          = [League]()
    var basketballLeagues   = [League]()
    var footballLeagues     = [League]()
    var cricketLeagues      = [League]()
    var tennisLeagues       = [League]()
    let navBarTitle = "Favourite Leagues"
    let presenter = Presenter()
    @IBOutlet weak var favTableView: UITableView!
    var emptyImgView:UIImageView!
    var emptyMsgLabel:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
        UIHelper.addGradientSubViewToView(view: view, at: 0)
        UIHelper.addGradientSubView(view: view, tableView: favTableView)
        view.frame = view.bounds
        tabBarController?.title = navBarTitle
        presenter.attachToFavLeagueView(view: self)
        presenter.FetchfavLeaguesFromDataBase()
        addEmptyScreen()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.title = navBarTitle
        presenter.FetchfavLeaguesFromDataBase()
        favTableView.reloadData()
        favTableView.frame = view.bounds
        if favLeagues.count == 0 {
            favTableView.isHidden = true
            emptyImgView.isHidden = false
            emptyMsgLabel.isHidden = false
        }else{
            favTableView.isHidden = false
            emptyImgView.isHidden = true
            emptyMsgLabel.isHidden = true
        }
    }
    
    func renderFavLeaguesToTableView(res: [League]) {
        favLeagues.removeAll()
        favLeagues = res
        DispatchQueue.main.async {
            self.favTableView.reloadData()
        }
    }
    @objc func deleteAllFavLeagues(){
        CoreDataDB.sharedInstance.removeAllFavLeaguesFromDBModel()
        favTableView.reloadData()
    }
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTableView.dequeueReusableCell(withIdentifier: "favCell") as! FavTableViewCell
        cell.backgroundColor = UIColor.black
        if let url = URL(string: favLeagues[indexPath.row].league_logo ?? "https://img.freepik.com/premium-vector/carolina-champions-leaque-soccer-football-logo-design-vector-isolated_289688-1010.jpg?semt=ais_hybrid"){
            cell.favImgView.kf.setImage(with: url)
        }else{
            cell.favImgView.image = UIImage(named: "world-cup")
        }
        cell.favNameLB.text = favLeagues[indexPath.row].league_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDCVC = self.storyboard?.instantiateViewController(identifier: "leagueDetailsCVC") as! LeagueDetailsCollectionViewController
        //error out of range
        leagueDCVC.leagueIndex = favLeagues[indexPath.row].leagueIndex ?? 0
        leagueDCVC.leagueId = String(favLeagues[indexPath.row].league_key ?? 0)
        leagueDCVC.navigationItem.title = favLeagues[indexPath.row].league_name ?? "League"
        leagueDCVC.leagueDetails = favLeagues[indexPath.row]
        self.navigationController?.pushViewController(leagueDCVC, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Are you sure?", message: "You are going to delete \( favLeagues[indexPath.row].league_name ?? "the league")) league from favourites", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                
                self.presenter.removeTheLeagueFromFavourites(id: self.favLeagues[indexPath.row].league_key ?? 0)
                self.favLeagues.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                print("delete")
                if self.favLeagues.count == 0 {
                    self.favTableView.isHidden = true
                    self.emptyImgView.isHidden = false
                    self.emptyMsgLabel.isHidden = false
                }
            }
            alert.addAction(cancel)
            alert.addAction(delete)
            self.present(alert, animated: true)
        }
    }
    
    func addEmptyScreen(){
        emptyImgView = UIImageView(frame: CGRect(x: 110, y: 300, width: 200, height: 200))
        emptyImgView.image = UIImage(named: "noData2")
//        emptyImgView.tintColor = UIColor.white
        self.view.addSubview(emptyImgView)
        emptyMsgLabel = UILabel(frame: CGRect(x: emptyImgView.frame.minX, y: emptyImgView.frame.maxY, width: emptyImgView.frame.width, height: 30))
        emptyMsgLabel.text = "No favourite Leagues!"
        emptyMsgLabel.textColor = UIColor.systemGray2
        emptyMsgLabel.textAlignment = .center
        emptyMsgLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        view.addSubview(emptyMsgLabel)
    }
    
//    func convertToFourLeagues(){
//        for favLeague in favLeagues {
//            if favLeague.leagueIndex == 0 {
//                footballLeagues.append(favLeague)
//            }else if favLeague.leagueIndex == 1 {
//                basketballLeagues.append(favLeague)
//            }else if favLeague.leagueIndex == 2 {
//                cricketLeagues.append(favLeague)
//            }else if favLeague.leagueIndex == 3 {
//                cricketLeagues.append(favLeague)
//            }
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
