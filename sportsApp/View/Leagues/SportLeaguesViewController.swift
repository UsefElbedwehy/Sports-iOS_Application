//
//  SportLeaguesViewController.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import UIKit
import Kingfisher
import Reachability



let leaguesPlaceholderAddress = ["https://static.vecteezy.com/system/resources/previews/036/289/043/non_2x/football-premier-league-logo-design-vector.jpg"
    ,"https://img.freepik.com/free-vector/gradient-basketball-logo_52683-84313.jpg?semt=ais_hybrid"
    ,"https://www.shutterstock.com/image-vector/cricket-academy-sport-player-logo-600nw-2398285463.jpg"
    ,"https://c8.alamy.com/comp/2R2KBJ5/tennis-sport-tennis-club-logo-green-stamp-badge-tennis-ball-club-emblem-design-template-on-white-background-2R2KBJ5.jpg"]
var reachability:Reachability!
protocol HomeProtocol {
    func renderDataToView(res:Leagues)
}
class SportLeaguesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , HomeProtocol, UISearchResultsUpdating{
    @IBOutlet weak var leaguesTableView: UITableView!
    let searchController = UISearchController()
    let presenter = Presenter()
    var leagueIndex = 0
    var leaguesArray  = [League]()
    var filteredArray = [League]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initNetworkChecker()
        setBackgroudGradient()
        presenter.attachToView(view: self)
        leaguesTableView.delegate   = self
        leaguesTableView.dataSource = self
        navigationController?.setCustomBackButton(for: navigationItem)
        addSearchBar()
//        self.leaguesTableView.startActivityIndicator()
        self.view.startActivityIndicator()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        startCheckingNetwork()
    }
    func renderDataToView(res:Leagues) {
        
        leaguesArray = res.result!
        DispatchQueue.main.async {
            self.view.stopActivityIndicator()
            self.leaguesTableView.reloadData()
        }
    }
    func setBackgroudGradient(){
        UIHelper.addGradientSubViewToView(view: view, at: 0)
        UIHelper.addGradientSubView(view: view, tableView: leaguesTableView)
        view.frame = view.bounds
    }
    //TableView ------------------------------------------------
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredArray.count
        }else{
            return leaguesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaguesTableView.dequeueReusableCell(withIdentifier: "SportLeaguescell", for: indexPath) as! SportLeagueTopCell
        if searchController.isActive {
            cell.leagueNameLabel.text = filteredArray[indexPath.row].league_name
            let strUrl = filteredArray[indexPath.row].league_logo ?? leaguesPlaceholderAddress[leagueIndex]
            let url = URL(string: strUrl)
            if let url = url {
                cell.leagueLogoImgView.kf.setImage(with: url)
            }else{
                cell.leagueLogoImgView.image = UIImage(named: "ftPlaceHolder")
            }
        }else{
            cell.leagueNameLabel.text = leaguesArray[indexPath.row].league_name
            let strUrl = leaguesArray[indexPath.row].league_logo ?? leaguesPlaceholderAddress[leagueIndex]
            let url = URL(string: strUrl)
            if let url = url {
                cell.leagueLogoImgView.kf.setImage(with: url)
            }else{
                cell.leagueLogoImgView.image = UIImage(named: "ftPlaceHolder")
            }
        }
            
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive {
            let leagueDCVC = self.storyboard?.instantiateViewController(identifier: "leagueDetailsCVC") as! LeagueDetailsCollectionViewController
            filteredArray[indexPath.row].leagueIndex = leagueIndex
            leagueDCVC.leagueIndex = leagueIndex
            leagueDCVC.leagueId = String(filteredArray[indexPath.row].league_key ?? 0)
            leagueDCVC.navigationItem.title = filteredArray[indexPath.row].league_name ?? "League"
            leagueDCVC.leagueDetails = filteredArray[indexPath.row]
            self.navigationController?.pushViewController(leagueDCVC, animated: true)
        }else{
            let leagueDCVC = self.storyboard?.instantiateViewController(identifier: "leagueDetailsCVC") as! LeagueDetailsCollectionViewController
            leaguesArray[indexPath.row].leagueIndex = leagueIndex
            leagueDCVC.leagueIndex = leagueIndex
            leagueDCVC.leagueId = String(leaguesArray[indexPath.row].league_key ?? 0)
            leagueDCVC.navigationItem.title = leaguesArray[indexPath.row].league_name ?? "League"
            leagueDCVC.leagueDetails = leaguesArray[indexPath.row]
            self.navigationController?.pushViewController(leagueDCVC, animated: true)
        }
        }
    //Search--------------------------------------------------------
    func addSearchBar(){
        searchController.searchBar.placeholder = "Search for leagues"
        searchController.searchBar.tintColor = .systemPink
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchTxt = searchController.searchBar.text else {
            return
        }
        print(searchTxt)
        
        if searchTxt.isEmpty {
            filteredArray = leaguesArray
        } else {
            filteredArray = leaguesArray.filter { league in
                league.league_name!.lowercased().contains(searchTxt.lowercased())
            }
        }
        leaguesTableView.reloadData()
    }
    
    //Reachability -----------------------------------------
    func initNetworkChecker(){
        reachability = try! Reachability()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
    }
    func startCheckingNetwork(){
            do{
              try reachability.startNotifier()
            }catch{
              print("could not start reachability notifier")
            }
    }
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
          leaguesTableView.isHidden = false
          presenter.FetchLeaguesFromJson(leagueIndex)
      case .cellular:
          print("Reachable via Cellular")
          leaguesTableView.isHidden = false
          presenter.FetchLeaguesFromJson(leagueIndex)
      case .unavailable:
        print("Network not reachable")
          leaguesTableView.isHidden = true
          alertForNetworkFailure()
      }
    }
    func stopCheckingNetwork(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    //Alert --------------
    func alertForNetworkFailure(){
        let alert = UIAlertController(title: "You are Offline!", message: "Connect to go through the leagues!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: {_ in 
            self.navigationController?.popToRootViewController(animated: true)
        }
        )
        alert.addAction(ok)
        self.present(alert, animated: true)
    }

}
