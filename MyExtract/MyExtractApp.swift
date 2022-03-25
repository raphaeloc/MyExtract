//
//  MyExtractApp.swift
//  MyExtract
//
//  Created by Raphael de Oliveira Chagas on 24/03/22.
//

import SwiftUI

@main
struct MyExtractApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView()
                    .environmentObject(LoginViewModel())
            }
        }
    }
}
