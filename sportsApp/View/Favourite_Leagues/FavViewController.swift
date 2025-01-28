//
//  FavViewController.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import UIKit

class FavViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.layer.addSublayer(UIHelper.createGradientLayer(view))
        tabBarController?.title = "Favourite Leagues"
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.title = "Favourite Leagues"
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
