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
            Content(
                accounts: $model.accounts,
                move: model.move,
                new: { addingAccount = true },
                update: model.update(account:)
            )
        }
        .sheet(isPresented: $addingAccount) {
            NavigationStack {
                New(add: model.addAccount)
            }
            .presentationDetents([.fraction(0.5)])
            .interactiveDismissDisabled()
        }
    }
}

// MARK: - Content
extension AccountsView {
    struct Content: View {
        @Binding var accounts: [Account]
        let move: (IndexSet, Int) -> Void
        let new: () -> Void
        let update: (Account) -> Void
        
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
                AddButton(title: "New Account", action: new)
            }
            .navigationBarTitle("Accounts")
            .navigationBarItems(trailing: EditButton())
            .navigationDestination(for: Account.self) { account in
                TransactionsView(account: account, update: update)
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
        AccountsView.Content(accounts: .constant(.preview), move: {_,_ in}, new: {}, update: {_ in})
    }
}
