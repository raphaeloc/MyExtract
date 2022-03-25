//
//  AddStatementView.swift
//  MyExtract
//
//  Created by Raphael de Oliveira Chagas on 23/03/22.
//

import SwiftUI

struct AddStatementView: View {
    
    @Binding var shouldKeepPresented: Bool
    
    @State var name = ""
    @State var statementType = "credit card"
    
    @EnvironmentObject var viewModel: AddStatementViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            VStack(alignment: .center) {
                Text("Add statement")
                    .font(.system(.title))
                    .padding(.vertical, 16)
            }
            .frame(maxWidth: .infinity)
            
            TextField("name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 16)
            
                .padding(.vertical, 8)
            
            HStack {
                Image(systemName: "creditcard")
                    .resizable()
                    .frame(width: 32, height: 24)
                
                
                Picker("statement type", selection: $statementType) {
                    ForEach(viewModel.statementTypes, id: \.self) { statementType in
                        Text(statementType)
                            .foregroundColor(.black)
                    }
                }
                .accentColor(.black)
                .pickerStyle(.menu)
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            Button("confirm") {
                viewModel.saveStatement(name: name, type: statementType, completion: {
                    shouldKeepPresented = !viewModel.savedSuccessful
                })
            }
            .frame(maxWidth: .infinity, maxHeight: 48)
            .font(.system(size: 18, weight: .semibold))
            .tint(.white)
            .background(Rectangle().fill(Color.black).cornerRadius(16))
            .padding(.horizontal, 16)
        }
    }
}

struct AddStatementView_Previews: PreviewProvider {
    @State static var shouldPresent = true
    
    static var previews: some View {
        AddStatementView(shouldKeepPresented: $shouldPresent)
            .environmentObject(AddStatementViewModel())
    }
}
