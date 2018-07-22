//
//  Api.swift
//  Examples
//
//  Created by Devin Turner on 7/21/18.
//

import Foundation

let baseUrl = "https://argeoguesser.azurewebsites.net"
//let baseUrl = "http://localhost:8080"

func register(password: String, onSuccess: @escaping (String) -> Void ) {
    guard let url = URL(string: "\(baseUrl)/register?password=\(password)") else {
        print("Error: cannot create register URL")
        return
    }
    
    let session = URLSession(configuration: .default)
    session.dataTask(with: url) { (data, response, error) in
        guard error == nil, let data = data else { return }
        
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
        
        guard let profile = dict?["profile"] as? [String: String?] else { return }
        
        onSuccess(profile["login"]!!)
    }.resume()
}

func updateUser(_ userUpdate: UserUpdate, onComplete: @escaping () -> Void) {
    guard let url = URL(string: "\(baseUrl)/user/update") else {
        print("Error: cannot create update URL")
        onComplete()
        return
    }
    
    let session = URLSession(configuration: .default)
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: userUpdate.dictionary, options: []) else {
        print("Could not serialize user update to JSON")
        onComplete()
        return
    }
    request.httpBody = httpBody
    session.dataTask(with: request) { (data, response, error) in
        guard error == nil else {
            onComplete()
            return
        }
        
        print("Successfully updated user")
        onComplete()
    }
}

class UserUpdate {
    let email: String
    let oldNickName: String
    let newNickName: String?
    
    required init(email: String, oldNickName: String, newNickName: String? = nil) {
        self.email = email
        self.oldNickName = oldNickName
        self.newNickName = newNickName
    }
    
    var dictionary: [String: String?] {
        return ["email": email, "oldNickName": oldNickName, "newNickName": newNickName]
    }
}
