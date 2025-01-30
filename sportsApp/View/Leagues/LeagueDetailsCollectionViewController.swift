//
//  LeagueDetailsCollectionViewController.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import UIKit
protocol LeagueProtocol {
//    func renderUpComingMatchesToView(res: )
    func renderLatestMatchesToView(res: Fixtures)
    func renderTeamsToView(res: Teams)
}

private let reuseIdentifier = "lagueDCell"
var isGradientCell = false
class LeagueDetailsCollectionViewController: UICollectionViewController ,LeagueProtocol {
    var leagueIndex = 0
    var fixturesArray = [Fixture]()
    var teamsArray = [Team]()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
        UIHelper.addGradientSubViewToView(view: view)
        compsitionalLayoutInit()
        NavBarSetUp.setBackBtn(navigationItem: navigationItem, navController: navigationController!)
        let presenter = Presenter()
        presenter.attachToLeagueView(view: self)
        presenter.FetchTeamsFromJson(leagueIndex)
        presenter.FetchFixtureFromJson(leagueIndex)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 10
        case 1:
            return fixturesArray.count
        default:
            return teamsArray.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let matchCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lagueDCell", for: indexPath) as! MiddleMatchCollectionViewCell
        UIHelper.removeExistingGradients(from: matchCardCell.matchCardView)
        UIHelper.addGradientSubViewToCell(view: matchCardCell.matchCardView, at:0)
        UIHelper.addGradientSubViewToMatchCardCell(view: matchCardCell.matchCardView, at: 0)
        matchCardCell.matchCardView.backgroundColor = UIColor.black
        matchCardCell.layer.cornerRadius = 15
        switch indexPath.section {
        case 0:
            matchCardCell.homeTeamLB.text = "Yeees"
        case 1:
            matchCardCell.homeTeamLB.text = fixturesArray[indexPath.row].event_home_team
            matchCardCell.awayTeamLB.text = fixturesArray[indexPath.row].event_away_team
            matchCardCell.matchDateLB.text = fixturesArray[indexPath.row].event_date
            matchCardCell.matchTimeLB.text = fixturesArray[indexPath.row].event_time
            let homeUrl = URL(string: fixturesArray[indexPath.row].home_team_logo ?? "https://images-platform.99static.com/4UjFKF0lqaqTGtHZIUNsYeNeUak=/500x500/top/smart/99designs-contests-attachments/45/45950/attachment_45950568")
            let awayUrl = URL(string: fixturesArray[indexPath.row].away_team_logo ?? "https://marketplace.canva.com/EAF7iHWkPBk/1/0/1600w/canva-blue-and-yellow-circle-modern-football-club-badge-logo-B4ALVxfLQS0.jpg")
            matchCardCell.homeTeamImgView.kf.setImage(with: homeUrl)
            matchCardCell.awayTeamImgView.kf.setImage(with: awayUrl)
            
        default:
            matchCardCell.homeTeamLB.text = "Nooo"
        }
    
        return matchCardCell
    }

    func compsitionalLayoutInit() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex , enviroment in
            switch sectionIndex {
            case 0:
                return self.drawTopSection()
            case 1:
                return self.drawMiddleSection()
            default:
                return self.drawBottomSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func drawTopSection() -> NSCollectionLayoutSection {
        let section = drawHorizontalSection()
        return section
    }
    func drawMiddleSection() -> NSCollectionLayoutSection {
        return drawShapeOfSection()
    }
    func drawBottomSection() -> NSCollectionLayoutSection {
        let section = drawHorizontalSection()
        return section
    }
    func drawHorizontalSection() -> NSCollectionLayoutSection {
        let section = drawShapeOfSection()
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    func drawShapeOfSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 13.0, bottom: 10.0, trailing: 13.0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        return section
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            //nav to players
            let teamVC = self.storyboard?.instantiateViewController(identifier: "teamVC") as! TeamDetailsViewController
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

}
