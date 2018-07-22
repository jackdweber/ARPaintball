//
//  GameTableViewController.swift
//  Examples
//
//  Created by Jack Weber on 7/21/18.
//  Copyright © 2018 MapBox. All rights reserved.
//

import UIKit

class GameTableViewController: UITableViewController {
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    let games = Games()
    let cheats = UserDefaults.standard.bool(forKey: "cheats")

    override func viewDidLoad() {
        super.viewDidLoad()
        let settingsButton = UIButton(type: .infoLight)
        settingsButton.addTarget(self, action: #selector(launchSettings), for: UIControlEvents.touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        tableView.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func launchSettings() {
        performSegue(withIdentifier: "showSettings", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") else {
            return UITableViewCell()
        }
        if cheats {
            cell.textLabel?.text = Array(games.getAll().keys)[indexPath.row]
            return cell
        }
        let title = games.library[indexPath.row].first?.key
        cell.textLabel?.text = title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cheats {
            let key = Array(games.getAll().keys)[indexPath.row]
            performSegue(withIdentifier: "startGame", sender: (key, games.getAll()[key]))
            return
        }
        let random = games.library[indexPath.row].first!.value.randomElement()
        guard let coords = random?.value, let name = random?.key else {
            return
        }
        
        performSegue(withIdentifier: "startGame", sender: (name, coords))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if cheats {
            return games.getAll().count
        }
        return games.library.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let arvc = segue.destination as? DemoARViewController, let payload = sender as? (String, (Double, Double, Double, Double)) else {
            return
        }
        arvc.cityCoords = payload.1
        arvc.cityName = payload.0
    }

    

}
