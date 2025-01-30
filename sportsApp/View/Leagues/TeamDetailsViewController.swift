//
//  TeamDetailsViewController.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIHelper.addGradientSubViewToView(view: view)
        NavBarSetUp.setBackBtn(navigationItem: navigationItem, navController: navigationController!)
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
