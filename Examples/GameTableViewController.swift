//
//  GameTableViewController.swift
//  Examples
//
//  Created by Jack Weber on 7/21/18.
//  Copyright © 2018 MapBox. All rights reserved.
//

import UIKit

class GameTableViewController: UITableViewController {
    
    let games = Games()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") else {
            return UITableViewCell()
        }
        let title = games.library[indexPath.row].first?.key
        cell.textLabel?.text = title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let random = games.library[indexPath.row].first!.value.randomElement()
        guard let coords = random?.value, let name = random?.key else {
            return
        }
        performSegue(withIdentifier: "startGame", sender: (name, coords))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
