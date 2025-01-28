//
//  LeagueDetailsCollectionViewController.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import UIKit

private let reuseIdentifier = "lagueDCell"
var isGradientCell = false
class LeagueDetailsCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true

        // Do any additional setup after loading the view.
        view.layer.addSublayer(UIHelper.createGradientLayer(self.view))
        compsitionalLayoutInit()
        let backButton = UIBarButtonItem(title: "Custom", style: .plain, target: self, action: #selector(popScreen)    )
        backButton.image = UIImage(named: "previous") //Replaces title
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    @objc func popScreen(){
        navigationController?.popViewController(animated: true)
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
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
        case 0:
            return 10
        case 1:
            return 10
        default:
            return 10
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lagueDCell", for: indexPath)
    
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor.black
            let tempView = UIView()
            tempView.layer.addSublayer(UIHelper.createGradientLayerForCell(view))
            cell.backgroundView = tempView
            cell.layer.cornerRadius = 15
        case 1:
            cell.backgroundColor = UIColor.black
            let tempView = UIView()
            tempView.layer.addSublayer(UIHelper.createGradientLayerForCell(view))
            cell.backgroundView = tempView
            cell.layer.cornerRadius = 15
        default:
            cell.backgroundColor = UIColor.black
            let tempView = UIView()
            tempView.layer.addSublayer(UIHelper.createGradientLayerForCell(view))
            cell.backgroundView = tempView
            cell.layer.cornerRadius = 15
        }
    
        return cell
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
