//
//  AddStatementService.swift
//  MyExtract
//
//  Created by Raphael de Oliveira Chagas on 23/03/22.
//

import Foundation

class AddStatementService {
    
    func saveStatement(dict: [String: String], result: @escaping (Result<Bool, ExtractError>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/saveStatement"),
              let data = try? JSONEncoder().encode(dict) else { fatalError("Missing URL") }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = data
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let _ = error {
                result(.failure(.requestError("An internal error ocourred, try again later")))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                      result(.failure(.decodeError("An internal error ocourred, try again later")))
                      return
                  }
            
            result(.success(true))
        }
        
        dataTask.resume()
    }
}
