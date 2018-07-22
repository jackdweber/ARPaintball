//
//  MultiPlayTableViewController.swift
//  Examples
//
//  Created by Jack Weber on 7/21/18.
//  Copyright © 2018 MapBox. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MultiPlayTableViewController: UITableViewController, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        if state == MCSessionState.connected {
            print("Started")
            performSegue(withIdentifier: "showMultiStart", sender: false)
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
    
    var items: (MCSession, String, (Double, Double, Double, Double))!
    var peers: [MCPeerID] = []
    let browser = MCNearbyServiceBrowser(peer: MCPeerID(displayName: UIDevice.current.name), serviceType: "ARGG")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        browser.delegate = self
        items.0.delegate = self
        
        let alert = UIAlertController(title: "Select", message: "Would you like to join or host?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Join", style: .default, handler: { (_) in
            print("Join")
            self.browser.startBrowsingForPeers()
        }))
        alert.addAction(UIAlertAction(title: "Host", style: .default, handler: { (_) in
            print("Host")
            
        }))
        present(alert, animated: true, completion: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        peers.append(peerID)
        tableView.reloadData()
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        if let index = peers.firstIndex(of: peerID) {
            peers.remove(at: index)
            tableView.reloadData()
        }
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, items.0)
        performSegue(withIdentifier: "showMultiStart", sender: true)
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return peers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeerCell", for: indexPath)

        cell.textLabel?.text = peers[indexPath.row].displayName

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        browser.invitePeer(peers[indexPath.row], to: items.0, withContext: nil, timeout: 15)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let arvc = segue.destination as? DemoARViewController, let host = sender as? Bool else {
            return
        }
        arvc.cityName = items.1
        arvc.mcSession = items.0
        arvc.cityCoords = items.2
        arvc.host = host
    }

}
