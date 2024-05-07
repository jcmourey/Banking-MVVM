//
//  ContentView.swift
//  Banking MVVM
//
//  Created by Jean-Charles Mourey on 07/05/2024.
//

import SwiftUI

struct AccountsView: View {
    @State private var model = ViewModel()
    @State private var addingAccount = false
    
    var body: some View {
        NavigationStack {
            Content(accounts: model.accounts, move: model.move, newAccount: { addingAccount = true })
        }
        .sheet(isPresented: $addingAccount) {
            NavigationStack {
                NewAccountView(add: model.addAccount)
            }
        }
    }
}

// MARK: - Content
extension AccountsView {
    struct Content: View {
        let accounts: [Account]
        let move: (IndexSet, Int) -> Void
        let newAccount: () -> Void
        
        var body: some View {
            VStack {
                List {
                    ForEach(accounts) { account in
                        NavigationLink(value: account) {
                            Row(account: account)
                        }
                    }
                    .onMove(perform: move)
                }
                AddButton(title: "New Account", action: newAccount)
            }
            .navigationBarTitle("Accounts")
            .navigationBarItems(trailing: EditButton())
            .navigationDestination(for: Account.self) { account in
                TransactionsView(account: account, accounts: accounts)
            }
        }
       
    }
}

// MARK: - Row
extension AccountsView.Content {
    struct Row: View {
        let account: Account
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4.0) {
                HStack {
                    Text(account.name)
                        .font(.headline)
                    Spacer()
                    Text(account.balance.currencyFormat)
                        .font(.headline)
                }
                Text("\(account.kind.rawValue.capitalized) account")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(account.iban.ibanFormat)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 8.0)
        }
    }
}

#Preview {
    NavigationStack {
        AccountsView.Content(accounts: .preview, move: {_,_ in }, newAccount: {})
    }
}
