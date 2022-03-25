//
//  StatementService.swift
//  MyExtract
//
//  Created by Raphael de Oliveira Chagas on 23/03/22.
//

import Foundation

class StatementService {
    
    func fetchStatements(result: @escaping (Result<Statements, ExtractError>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/statements") else {
            result(.failure(.internalError("An internal error ocourred, try again later")))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let _ = error {
                result(.failure(.requestError("An internal error ocourred, try again later")))
                return
            }
            
            guard let data = data,
                  let decoded = try? JSONDecoder().decode(Statements.self, from: data) else {
                      result(.failure(.decodeError("An internal error ocourred, try again later")))
                      return
                  }
            
            result(.success(decoded))
        }
        
        dataTask.resume()
    }
    
    func deleteStatement(dict: [String: String], result: @escaping (Result<Statements, ExtractError>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/deleteStatement"),
              let data = try? JSONEncoder().encode(dict) else {
            result(.failure(.internalError("An internal error ocourred, try again later")))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        urlRequest.httpBody = data
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let _ = error {
                result(.failure(.requestError("An internal error ocourred, try again later")))
                return
            }
            
            guard let data = data,
                  let decoded = try? JSONDecoder().decode(Statements.self, from: data) else {
                      result(.failure(.decodeError("An internal error ocourred, try again later")))
                      return
                  }
            
            result(.success(decoded))
        }
        
        dataTask.resume()
    }
}

enum ExtractError: Error {
    case requestError(String)
    case internalError(String)
    case decodeError(String)
}
