//
//  AccountsView.Model.swift
//  Banking MVVM
//
//  Created by Jean-Charles Mourey on 07/05/2024.
//

import Foundation

extension AccountsView {
    @Observable class ViewModel {
        var accounts: [Account]
        
        private let storageController = StorageController()
        
        init() {
            accounts = storageController.fetchAccounts()
        }
        
        func addAccount(named name: String, withKind kind: Account.Kind) {
            let account = Account(name: name, iban: .generateIban(), kind: kind)
            accounts.append(account)
            storageController.save(accounts)
        }
        
        func move(fromOffsets source: IndexSet, toOffset destination: Int) {
            accounts.move(fromOffsets: source, toOffset: destination)
        }
    }
}

extension String {
    static func generateIban() -> String {
        func randomString(lenght: Int, from characters: String) -> String {
            String((0 ..< lenght).map { _ in characters.randomElement()! })
        }
        
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let digits = "0123456789"
        return randomString(lenght: 2, from: letters)
            + randomString(lenght: 2, from: digits)
            + randomString(lenght: 4, from: letters)
            + randomString(lenght: 12, from: digits)
    }
}

