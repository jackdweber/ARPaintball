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
    override func viewDidAppear(_ animated: Bool) {
        guard !OktaAuth.isAuthenticated() else { return }
        
        let password = generatePassword()
        register(password: password) { nickName in
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
