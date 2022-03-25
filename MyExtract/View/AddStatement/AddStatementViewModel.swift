//
//  AddStatementViewModel.swift
//  MyExtract
//
//  Created by Raphael de Oliveira Chagas on 23/03/22.
//

import Foundation

class AddStatementViewModel: ObservableObject {
    
    enum StatementType: String {
        case creditCard = "credit card"
        case money
    }
    
    @Published var savedSuccessful = false
    @Published var shouldShowSaveError = false
    
    let statementTypes = ["credit card", "money"]
    let service = AddStatementService()
    
    func saveStatement(name: String, type: String, completion: @escaping () -> Void) {
        guard let statementType = StatementType(rawValue: type) else {
            shouldShowSaveError = true
            completion()
            return
        }
        
        let type: Statement.StatementType
        
        switch statementType {
        case .creditCard:
            type = .creditCard
        case .money:
            type = .money
        }
        
        service.saveStatement(dict: ["id": UUID().uuidString, "name": name, "type": type.rawValue]) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.savedSuccessful = true
                case .failure(_):
                    self?.shouldShowSaveError = true
                }
                
                completion()
            }
        }
    }
}
