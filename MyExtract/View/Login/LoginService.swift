//
//  LoginService.swift
//  MyExtract
//
//  Created by Raphael de Oliveira Chagas on 22/03/22.
//

import Foundation

class LoginService {
    
    func doLogin(dict: [String: String], result: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3000/login"),
              let data = try? JSONEncoder().encode(dict) else { result(false); return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = data
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let _ = error {
                result(false)
                return
            }
            
            guard let data = data,
                  let decoded = try? JSONDecoder().decode(Bool.self, from: data) else { result(false); return }
            
            result(decoded)
        }
        
        dataTask.resume()
    }
}
