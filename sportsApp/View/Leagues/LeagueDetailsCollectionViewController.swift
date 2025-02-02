//
//  LeagueDetailsCollectionViewController.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import UIKit
import Reachability

protocol LeagueProtocol {
    func renderLatestMatchesToView(res: Fixtures)
    func renderTeamsToView(res: Teams)
    func renderUpcomingMatchesToView(res: Fixtures)
    func chechFavourite(res: Bool)
}

class LeagueDetailsCollectionViewController: UICollectionViewController ,LeagueProtocol {
    
    var leagueIndex = 0
    var leagueId    = "0"
    var isInitialFavourite = true
    var leagueDetails:League!
    var fixturesArray = [Fixture]()
    var upComingArray = [Fixture]()
    var teamsArray = [Team]()
    let sectionsHeader = ["Upcoming  matches","Latest matches","Teams"]
    let awayPlaceHolder = "https://marketplace.canva.com/EAF7iHWkPBk/1/0/1600w/canva-blue-and-yellow-circle-modern-football-club-badge-logo-B4ALVxfLQS0.jpg"
    let homePlaceHolder = "https://images-platform.99static.com/4UjFKF0lqaqTGtHZIUNsYeNeUak=/500x500/top/smart/99designs-contests-attachments/45/45950/attachment_45950568"
    let teamLogoPlaceHolder = "https://e7.pngegg.com/pngimages/710/859/png-clipart-logo-football-team-football-logo-design-free-logo-design-template-label.png"
    let presenter = Presenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
        initNetworkChecker()
        presenter.attachToLeagueView(view: self)
//        presenter.FetchTeamsFromJson(leagueIndex,leagueID: leagueId)
//        presenter.FetchFixtureFromJson(leagueIndex,leagueID: leagueId)
//        presenter.FetchUpComingFixtureFromJson(leagueIndex,leagueID: leagueId)
        UIHelper.addGradientSubViewToView(view: view)
        compsitionalLayoutInit()
        NavBarSetUp.setBackBtn(navigationItem: navigationItem, navController: navigationController!)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.09, green: 0.008, blue: 0.051, alpha: 1)
//        sleep(UInt32(0.18))
    }
    override func viewWillAppear(_ animated: Bool) {
        isFavourite()
        startCheckingNetwork()
    }
    func isFavourite(){
        presenter.isFound(id:leagueDetails.league_key ?? 28)
    }
    @objc func addToFav(){
        isFavourite()
    }
    func renderLatestMatchesToView(res: Fixtures) {
        guard let result = res.result else {
                print("Error: Fixtures result is nil")
                return
            }
            fixturesArray = result
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func renderUpcomingMatchesToView(res: Fixtures) {
        guard let result = res.result else {
                print("Error: Fixtures result is nil")
                return
            }
        upComingArray = result
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func renderTeamsToView(res: Teams) {
        guard let result = res.result else {
                print("Error: Teams result is nil")
                return
            }
            teamsArray = result
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func chechFavourite(res: Bool) {
        if isInitialFavourite == true{
            isInitialFavourite = false
            if res == true {
                let favButton = UIBarButtonItem(title: "favourite", style: .plain, target: self, action: #selector(addToFav))
                favButton.image = UIImage(named: "fav") //Replaces title
                navigationItem.setRightBarButton(favButton, animated: false)
            }else{
                let favButton = UIBarButtonItem(title: "favourite", style: .plain, target: self, action: #selector(addToFav))
                favButton.image = UIImage(named: "unfav") //Replaces title
                navigationItem.setRightBarButton(favButton, animated: false)
            }
        }else{
            if res == true {
                setUnFavImg()
                presenter.removeTheLeagueFromFavourites(id: leagueDetails.league_key ?? 0)
            }else{
                setFavImg()
                presenter.saveLeagueToFavLeagues(leagues: [leagueDetails]/*,index:leagueIndex*/)
            }
        }
    }
    func setFavImg(){
        navigationItem.rightBarButtonItem?.image = UIImage(named: "fav")
    }
    func setUnFavImg(){
        navigationItem.rightBarButtonItem?.image = UIImage(named: "unfav")
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return upComingArray.count
        case 1:
            return fixturesArray.count
        default:
            return teamsArray.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let topMatchCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "topMatchCell", for: indexPath) as! TopMatchCollectionViewCell
            addGradientToUpComingMatchesCard(topMatchCardCell: topMatchCardCell)
            topMatchCardCell.homeTeamNameLB.text = upComingArray[indexPath.row].event_home_team
            topMatchCardCell.awayTeamNameLB.text = upComingArray[indexPath.row].event_away_team
            topMatchCardCell.matchDateLB.text = upComingArray[indexPath.row].event_date
            topMatchCardCell.matchTimeLB.text = upComingArray[indexPath.row].event_time
            topMatchCardCell.stadiumNameLB.text = upComingArray[indexPath.row].event_stadium
            setUpcomingTeamsImage(topMatchCardCell: topMatchCardCell, indexPath: indexPath)
            return topMatchCardCell
        case 1:
            let matchCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lagueDCell", for: indexPath) as! MiddleMatchCollectionViewCell
            addGradientToMatchCard(matchCardCell: matchCardCell)
            matchCardCell.staduimLabel.text = fixturesArray[indexPath.row].event_stadium
            matchCardCell.homeTeamLB.text   = fixturesArray[indexPath.row].event_home_team
            matchCardCell.awayTeamLB.text   = fixturesArray[indexPath.row].event_away_team
            matchCardCell.matchDateLB.text  = fixturesArray[indexPath.row].event_date
            matchCardCell.matchTimeLB.text  = fixturesArray[indexPath.row].event_time
            setMatchScore(matchCardCell: matchCardCell, indexPath: indexPath)
            setLatestTeamsImage(matchCardCell: matchCardCell, indexPath: indexPath)
            return matchCardCell
        default:
            let teamCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomTeamCell", for: indexPath) as! BottomTeamCollectionViewCell
            UIHelper.removeExistingGradients(from: teamCardCell.teamsCardView)
            UIHelper.addGradientSubViewToCell(view: teamCardCell.teamsCardView, at:0)
            UIHelper.addGradientSubViewToTeamsCell(view: teamCardCell.teamsCardView, at: 0)
            teamCardCell.backgroundColor = UIColor.black
            teamCardCell.layer.cornerRadius = 15
            setTeamLogoImage(teamCardCell: teamCardCell, indexPath: indexPath)
            return teamCardCell
        }
    }
    func addGradientToMatchCard(matchCardCell:MiddleMatchCollectionViewCell){
        UIHelper.removeExistingGradients(from: matchCardCell.matchCardView)
        UIHelper.addGradientSubViewToCell(view: matchCardCell.matchCardView, at:0)
        UIHelper.addGradientSubViewToMatchCardCell(view: matchCardCell.matchCardView, at: 0)
        matchCardCell.matchCardView.backgroundColor = UIColor.black
        matchCardCell.layer.cornerRadius = 15
    }
    func addGradientToUpComingMatchesCard(topMatchCardCell:TopMatchCollectionViewCell){
        UIHelper.removeExistingGradients(from: topMatchCardCell.upcomingMatchesView)
        UIHelper.addGradientSubViewToCell(view: topMatchCardCell.upcomingMatchesView, at:0)
        UIHelper.addGradientSubViewToMatchCardCell(view: topMatchCardCell.upcomingMatchesView, at: 0)
        topMatchCardCell.upcomingMatchesView.backgroundColor = UIColor.black
        topMatchCardCell.layer.cornerRadius = 15
    }
    func setMatchScore(matchCardCell:MiddleMatchCollectionViewCell , indexPath:IndexPath){
        var matchScore:[String] = (fixturesArray[indexPath.row].event_final_result?.components(separatedBy: "-")) ?? ["0", "0"]
        if matchScore.count == 0 {
            matchScore.append("0")
            matchScore.append("0")
        }else if matchScore.count == 1{
            matchScore[0] = "0"
            matchScore.append("0")
        }
            matchCardCell.homeTeamScoreLB.text = matchScore[0]
            matchCardCell.awayTeamScoreLB.text = matchScore[1]
    }
    func setLatestTeamsImage(matchCardCell:MiddleMatchCollectionViewCell , indexPath:IndexPath){
        if let homeUrl = URL(string: fixturesArray[indexPath.row].home_team_logo ?? homePlaceHolder){
            matchCardCell.homeTeamImgView.kf.setImage(with: homeUrl)
        }else{
            matchCardCell.homeTeamImgView.image = UIImage(named: "HomeTeamLogoPlaceHolder")
        }
        if let awayUrl = URL(string: fixturesArray[indexPath.row].away_team_logo ?? awayPlaceHolder){
            matchCardCell.awayTeamImgView.kf.setImage(with: awayUrl)
        }else{
            matchCardCell.awayTeamImgView.image = UIImage(named: "AwayTeamLogoPlaceHolder")
        }
    }
    func setUpcomingTeamsImage(topMatchCardCell:TopMatchCollectionViewCell , indexPath:IndexPath){
        if let homeUrl = URL(string: upComingArray[indexPath.row].home_team_logo ?? homePlaceHolder){
            topMatchCardCell.homeImgView.kf.setImage(with: homeUrl)
        }else{
            topMatchCardCell.homeImgView.image = UIImage(named: "HomeTeamLogoPlaceHolder")
        }
        if let awayUrl = URL(string: upComingArray[indexPath.row].away_team_logo ?? awayPlaceHolder){
            topMatchCardCell.awayImgView.kf.setImage(with: awayUrl)
        }else{
            topMatchCardCell.awayImgView.image = UIImage(named: "AwayTeamLogoPlaceHolder")
        }
    }
    func setTeamLogoImage(teamCardCell:BottomTeamCollectionViewCell , indexPath:IndexPath){
        if let teamUrl = URL(string: teamsArray[indexPath.row].team_logo ?? teamLogoPlaceHolder){
            teamCardCell.teamImgView.kf.setImage(with: teamUrl)
        }else{
            teamCardCell.teamImgView.image = UIImage(named: "HomeTeamLogoPlaceHolder")
        }
    }
    
    
    func compsitionalLayoutInit() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex , enviroment in
            switch sectionIndex {
            case 0:
//                if self.upComingArray.count != 0{
                    return self.drawTopSection(withHeader: true)
//                }else{
//                    return self.drawTopSection(withHeader: false)
//                }
                
            case 1:
//                if self.fixturesArray.count != 0{
                    return self.drawMiddleSection(withHeader: true)
//                }else{
//                    return self.drawMiddleSection(withHeader: false)
//                }
            default:
//                if self.teamsArray.count != 0{
                    return self.drawBottomSection(withHeader: true)
//                }else{
//                    return self.drawBottomSection(withHeader: false)
//                }
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func drawTopSection(withHeader: Bool) -> NSCollectionLayoutSection {
        let section = drawHorizontalSection(withHeader: withHeader)
        return section
    }
    func drawMiddleSection(withHeader: Bool) -> NSCollectionLayoutSection {
        return drawShapeOfSection(withHeader: withHeader)
    }
    func drawBottomSection(withHeader: Bool) -> NSCollectionLayoutSection {
        let section = drawHorizontalSection(withHeader: withHeader)
        return section
    }
    func drawHorizontalSection(withHeader: Bool) -> NSCollectionLayoutSection {
        let section = drawShapeOfSection(withHeader: withHeader)
        section.orthogonalScrollingBehavior = .continuous
        if withHeader {
            let headerSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.95),
                        heightDimension: .absolute(30)
                    )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            section.boundarySupplementaryItems = [header]
        }
        return section
    }
    func drawShapeOfSection(withHeader:Bool) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 13.0, bottom: 10.0, trailing: 13.0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        if withHeader {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.95),
                heightDimension: .absolute(30)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        }
        return section
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let teamVC = self.storyboard?.instantiateViewController(identifier: "teamVC") as! TeamDetailsViewController
            teamVC.teamID = teamsArray[indexPath.row].team_key ?? 50
            teamVC.playersArray = teamsArray[indexPath.row].players!
            teamVC.navigationItem.title = teamsArray[indexPath.row].team_name ?? "team"
            self.navigationController?.pushViewController(teamVC, animated: true)
            
        }
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "leagueSectionsHeader", for: indexPath) as! LeagueHeaderCollectionReusableView
        header.headerLB.text = sectionsHeader[indexPath.section]
        return header
    }
    //Reachability --------------
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
          collectionView.isHidden = false
          presenter.FetchTeamsFromJson(leagueIndex,leagueID: leagueId)
          presenter.FetchFixtureFromJson(leagueIndex,leagueID: leagueId)
          presenter.FetchUpComingFixtureFromJson(leagueIndex,leagueID: leagueId)
      case .cellular:
          print("Reachable via Cellular")
          collectionView.isHidden = false
          presenter.FetchTeamsFromJson(leagueIndex,leagueID: leagueId)
          presenter.FetchFixtureFromJson(leagueIndex,leagueID: leagueId)
          presenter.FetchUpComingFixtureFromJson(leagueIndex,leagueID: leagueId)
      case .unavailable:
        print("Network not reachable")
          collectionView.isHidden = true
          alertForNetworkFailure()
      }
    }
    func stopCheckingNetwork(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    //Alert --------------
    func alertForNetworkFailure(){
        let alert = UIAlertController(title: "You are Offline!", message: "Connect to see the league details!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: {_ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        )
        alert.addAction(ok)
        self.present(alert, animated: false)
    }
}
