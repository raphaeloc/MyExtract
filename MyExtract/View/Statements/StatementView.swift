//
//  StatementView.swift
//  MyExtract
//
//  Created by Raphael de Oliveira Chagas on 22/03/22.
//

import SwiftUI

struct StatementView: View {
    
    @EnvironmentObject var viewModel: StatementViewModel
    @State var showAddStatement = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                ForEach($viewModel.statements, id: \.self) { statement in
                    StatementCell(statement: statement.wrappedValue)
                        .padding(.horizontal, 16)
                }
                .onDelete(perform: viewModel.delete(at:))
            }
            .refreshable {
                viewModel.fetchStatements()
            }
            .listStyle(.plain)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                // some bottom-sticked content, or just –
                Color.clear
                    .frame(height: 72)
            }
            
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    showAddStatement.toggle()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .tint(.white)
                }
                .frame(width: 56, height: 56)
                .background(Color.black.cornerRadius(56 / 2))
                .sheet(isPresented: $showAddStatement) {
                    viewModel.fetchStatements()
                } content: {
                    AddStatementView(shouldKeepPresented: $showAddStatement)
                        .environmentObject(AddStatementViewModel())
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Statements")
        .onAppear {
            viewModel.fetchStatements()
        }
    }
}

struct StatementView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = StatementViewModel()
        viewModel.statements = [
            Statement(id: UUID().uuidString, name: "Compra 1", type: .creditCard),
            Statement(id: UUID().uuidString, name: "Compra 2", type: .money),
            Statement(id: UUID().uuidString, name: "Compra 3", type: .creditCard),
            Statement(id: UUID().uuidString, name: "Compra 4", type: .money)
        ]
        return StatementView()
            .environmentObject(viewModel)
    }
}

private struct StatementCell: View {
    
    @State var statement: Statement
    
    var image: String {
        switch statement.type {
            
        case .creditCard:
            return "creditcard"
        case .money:
            return "banknote"
        }
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: image)
                .resizable()
                .frame(width: 24, height: 24)
            
            Text(statement.name)
                .font(.system(size: 18, weight: .thin))
            
            Spacer()
        }
        .frame(height: 40)
    }
}

private struct FloatButtonView: View {
    
    @State var showAddStatement = false
    @Binding var viewModel: StatementViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                showAddStatement.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .tint(.white)
            }
            .frame(width: 56, height: 56)
            .background(Color.black.cornerRadius(56 / 2))
            .sheet(isPresented: $showAddStatement) {
                viewModel.fetchStatements()
            } content: {
                AddStatementView(shouldKeepPresented: $showAddStatement)
                    .environmentObject(AddStatementViewModel())
            }
        }
    }
}
