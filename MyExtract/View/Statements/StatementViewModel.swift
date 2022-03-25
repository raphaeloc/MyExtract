//
//  StatementViewModel.swift
//  MyExtract
//
//  Created by Raphael de Oliveira Chagas on 23/03/22.
//

import Foundation

class StatementViewModel: ObservableObject {
    
    let service = StatementService()
    
    @Published var statements = Statements()
    
    func fetchStatements() {
        service.fetchStatements { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let statements):
                    self?.statements = statements
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func delete(at indexSet: IndexSet) {
        guard let id = indexSet.map({ statements[$0].id }).first else { return }

        service.deleteStatement(dict: ["id": id]) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let statements):
                    self?.statements = statements
                case .failure(_):
                    break
                }
            }
        }
    }
}
