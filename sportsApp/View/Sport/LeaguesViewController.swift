//
//  LeaguesViewController.swift
//  sportsApp
//
//  Created by Usef on 27/01/2025.
//

import UIKit
import Reachability

class LeaguesViewController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var CollectionSubView: UIView!
    let reachability = try! Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        initBackGroundColor()
        UIHelper.addGradientSubViewToView(view: view, at: 0)
//        tabBarController?.title = "Sports"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.title = "Sports"
        startCheckingNetwork()
    }
    func initBackGroundColor() {
        view.backgroundColor = UIColor.black
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let allLeagues = self.storyboard?.instantiateViewController(identifier: "sportLVC") as! SportLeaguesViewController
        allLeagues.navigationItem.title = Sports.sports[indexPath.row] + " Leagues"
        allLeagues.leagueIndex = indexPath.row
        self.navigationController?.pushViewController(allLeagues, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LeaguesCollectionViewCell
        cell.titleLB.text = Sports.sports[indexPath.row].capitalized
        cell.titleLB.layer.borderWidth = 1.0
        cell.titleLB.layer.borderColor = UIColor.white.cgColor
        cell.imgView.image = UIImage(named: Sports.sports[indexPath.row].capitalized)
        cell.imgView.contentMode = .scaleAspectFill
        cell.viewLayer.layer.bounds = view.bounds
        cell.viewLayer.frame = view.bounds
        UIHelper.addGradientSubViewToView(view: cell.viewLayer, at: 0)
        UIHelper.addGradientSubView(view: cell.viewLayer, GardientColors: [UIColor.black.cgColor,UIColor.white.cgColor], at: 0)
        setCellConfigurations(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(UIScreen.main.bounds.size.width) + 20) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 50, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width/2-15, height: UIScreen.main.bounds.size.height/3)
    }
    
    func setCellConfigurations(_ cell: LeaguesCollectionViewCell){
        cell.layer.borderColor  = UIColor.systemPink.cgColor
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth  = 1.5
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        cell.layer.shadowRadius = 4
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //Reachability --------------
    func startCheckingNetwork(){
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
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
      case .cellular:
          print("Reachable via Cellular")
      case .unavailable:
        print("Network not reachable")
          alertForNetworkFailure()
      }
    }
    func stopCheckingNetwork(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    //Alert --------------
    func alertForNetworkFailure(){
        let alert = UIAlertController(title: "You are Offline!", message: "please, connect to the network to know the updated sports!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
