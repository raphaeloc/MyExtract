//
//  LoginViewModel.swift
//  MyExtract
//
//  Created by Raphael de Oliveira Chagas on 22/03/22.
//

import Foundation
import Combine

protocol LoginViewModelViewDelegate: AnyObject {
    func loginViewModel(_ viewModel: LoginViewModel, didDoLoginWith result: Bool)
}

class LoginViewModel: ObservableObject {
    
    weak var delegate: LoginViewModelViewDelegate?
    private var cancellables: Set<AnyCancellable> = []
    
    let service = LoginService()
    
    @Published var isLogged = false
    @Published var showError = false
    
    func doLogin(username: String, password: String) {
        service.doLogin(dict: ["username": username, "password": password]) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLogged = result
                self?.showError = !result
            }
        }
    }
}
