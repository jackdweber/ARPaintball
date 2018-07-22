//
//  StartViewController.swift
//  Examples
//
//  Created by Devin Turner on 7/21/18.
//  Copyright © 2018 MapBox. All rights reserved.
//

import UIKit
import OktaAuth

class StartViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        startButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        startButton.layer.cornerRadius = 5
        if let data = try? Data(contentsOf: URL(string: "https://cdn-images-1.medium.com/max/672/1*hJdmqVuL79jo8ly7_TvI0Q.png")!) {
            imageView.image = UIImage(data: data)
        }
        // Do any additional setup after loading the view.

        guard !OktaAuth.isAuthenticated() else { return }
        
        let password = generatePassword()
        register(password: password) { nickName in
            let defaults = UserDefaults.standard
            defaults.set(nickName, forKey: "nickName")
            defaults.synchronize()
            OktaAuth.login(nickName, password: password)
                .start(self)
                .then{ _ in
                    print("Logged in \(nickName)!")
                }
                .catch { error in
                    print("Failed to login \(nickName). \(error)")
                }
        }
    }

    
    private func generatePassword() -> String {
        let passwordCharacters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
        var password = ""
        
        for _ in 0..<16 {
            // generate a random index based on your array of characters count
            let rand = arc4random_uniform(UInt32(passwordCharacters.count))
            // append the random character to your string
            password.append(passwordCharacters[Int(rand)])
        }

        return password
    }
    
    
}
