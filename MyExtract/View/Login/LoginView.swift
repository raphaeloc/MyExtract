//
//  LoginView.swift
//  MyExtract
//
//  Created by Raphael de Oliveira Chagas on 22/03/22.
//

import SwiftUI

struct LoginView: View {

    @EnvironmentObject var viewModel: LoginViewModel
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        VStack {
            Text("MyExtract")
                .font(.system(size: 32, weight: .bold, design: .default))
            
            Spacer()
            
            VStack(spacing: 16) {
                TextField("user", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 16)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(TextInputAutocapitalization.never)
                
                SecureField("password ", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 16)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(TextInputAutocapitalization.never)
            }
                
            Spacer()
            
            Button("login") {
                viewModel.doLogin(username: username, password: password)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .background(Rectangle().fill((username == "" || password == "") ? Color(UIColor.lightGray) : .black).cornerRadius(8))
            .padding(.horizontal, 16)
            .tint(.white)
            .font(.system(size: 16, weight: .semibold))
            .disabled(username == "" || password == "")
            
            NavigationLink(destination:
                            StatementView()
                            .environmentObject(StatementViewModel())
                            .navigationBarBackButtonHidden(true),
                           isActive: $viewModel.isLogged) {
                EmptyView()
            }.hidden()
        }
        .alert("Error", isPresented: $viewModel.showError) {
            
        } message: {
            Text("The username or password is not correct, try again.")
        }
        .navigationBarHidden(true)

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
    }
}
