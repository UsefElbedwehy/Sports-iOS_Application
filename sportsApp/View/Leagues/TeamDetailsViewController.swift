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

        // Do any additional setup after loading the view.
        view.layer.addSublayer(UIHelper.createGradientLayer(self.view))
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
