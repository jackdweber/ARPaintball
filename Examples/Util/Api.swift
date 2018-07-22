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
