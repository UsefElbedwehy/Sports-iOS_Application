//
//  SportLeaguesViewController.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import UIKit

class SportLeaguesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var leaguesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(UIHelper.createGradientLayer(view))
        leaguesTableView.delegate   = self
        leaguesTableView.dataSource = self
        let backButton = UIBarButtonItem(title: "Custom", style: .plain, target: self, action: #selector(popScreen)    )
        backButton.image = UIImage(named: "previous") //Replaces title
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    @objc func popScreen(){
        navigationController?.popViewController(animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaguesTableView.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath)
        if cell.layer.sublayers?.count == 2 {
            cell.layer.addSublayer(UIHelper.createGradientLayerForCell(view))
        }
        setTableCellsConfiguartions(cell)
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
