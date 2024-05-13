//
//  AccountsView.Model.swift
//  Banking MVVM
//
//  Created by Jean-Charles Mourey on 07/05/2024.
//

import Foundation

extension AccountsView {
    @Observable final class ViewModel {
        private(set) var accounts: [Account]
        
        private let storageController = StorageController()
        
        init() {
            accounts = storageController.fetchAccounts()
        }
        
        func addAccount(named name: String, withKind kind: Account.Kind) {
            let account = Account(name: name, iban: .generateIban(), kind: kind)
            accounts.append(account)
            storageController.save(accounts)
        }
        
        func update(account: Account) {
            guard let index = accounts.firstIndex(where: { $0.id == account.id }) else { return }
            accounts[index] = account
            storageController.save(accounts)
        }
    
        func move(fromOffsets source: IndexSet, toOffset destination: Int) {
            accounts.move(fromOffsets: source, toOffset: destination)
        }
    }
}

extension String {
    static func generateIban() -> String {
        func randomString(length: Int, from characters: String) -> String {
            String((0 ..< length).map { _ in characters.randomElement()! })
        }
        
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let digits = "0123456789"
        return randomString(length: 2, from: letters)
            + randomString(length: 2, from: digits)
            + randomString(length: 4, from: letters)
            + randomString(length: 12, from: digits)
    }
}

