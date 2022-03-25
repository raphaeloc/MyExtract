//
//  Statement.swift
//  MyExtract
//
//  Created by Raphael de Oliveira Chagas on 23/03/22.
//

import Foundation

typealias Statements = [Statement]

struct Statement: Codable, Hashable {
    
    enum StatementType: String, Codable {
        case creditCard
        case money
    }
    
    let id: String
    let name: String
    let type: StatementType
}
