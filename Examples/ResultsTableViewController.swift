//
//  ResultsTableViewController.swift
//  Examples
//
//  Created by Jack Weber on 7/22/18.
//  Copyright © 2018 MapBox. All rights reserved.
//

import UIKit

struct EndInfo {
    var didWin: Bool!
    var choosen: String!
    var correct: String!
}

class ResultsTableViewController: UITableViewController {
    
    var endInfo: EndInfo!
    var json = JSON.null
    let games = Games()

    override func viewDidLoad() {
        super.viewDidLoad()
        let major: () -> Int = {
            var ret = 0
            var run = true
            while run == true {
                let arr = Array(self.games.library[ret].first!.value.keys)
                if arr.contains(self.endInfo.correct) {
                    run = false
                } else {
                    ret += 1
                }
            }
            return ret
        }
        print(major().description)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = json.dictionary?.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell"), let jsondic = json.dictionary else {
            return UITableViewCell()
        }
        cell.textLabel?.text = Array(jsondic.keys)[indexPath.row]
        return cell
    }
    
    func getData(_ i: Int) {
        let url = URL(string: "https://argeoguesser.azurewebsites.net/guess?mode=\(i)")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            self.json = try! JSON(data: data!)
            self.tableView.reloadData()
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
