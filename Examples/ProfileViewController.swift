//
//  ProfileViewController.swift
//  Examples
//
//  Created by Devin Turner on 7/21/18.
//  Copyright © 2018 MapBox. All rights reserved.
//

import Foundation
import UIKit
import OktaAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var indicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))

    
    override func viewWillAppear(_ animated: Bool) {
        nickNameTextField.text = UserDefaults.standard.string(forKey: "nickName") ?? ""
        
        indicator.activityIndicatorViewStyle = .gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    @IBAction func saveProfile(_ sender: Any) {
        indicator.startAnimating()
        
        guard let email = emailTextField.text, let oldNickName = UserDefaults.standard.string(forKey: "nickName") else { return }
        let userUpdate = UserUpdate(email: email, oldNickName: oldNickName, newNickName: nickNameTextField.text)
        updateUser(userUpdate) {
            let defaults = UserDefaults.standard
            defaults.set(self.nickNameTextField.text, forKey: "nickName")
            defaults.synchronize()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        OktaAuth.clear()
        OktaAuth.login()
            .start(self)
            .then { _ in
                print("Logged in as new user")
            }
            .catch { error in
                print("Failed to login")
            }
    }
}
