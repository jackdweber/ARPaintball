//
//  SettingsViewController.swift
//  Examples
//
//  Created by Jack Weber on 7/21/18.
//  Copyright © 2018 MapBox. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var switchHD: UISwitch!
    @IBOutlet weak var switchCheats: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchHD.isOn = UserDefaults.standard.bool(forKey: "hd")
        switchCheats.isOn = UserDefaults.standard.bool(forKey: "cheats")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toggleHD(_ sender: Any) {
        let current = UserDefaults.standard.bool(forKey: "hd")
        UserDefaults.standard.set(!current, forKey: "hd")
    }
    @IBAction func toggleCheats(_ sender: Any) {
        let current = UserDefaults.standard.bool(forKey: "cheats")
        UserDefaults.standard.set(!current, forKey: "cheats")
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
