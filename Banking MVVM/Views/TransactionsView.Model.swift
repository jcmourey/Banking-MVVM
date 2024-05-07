//
//  TransactionsView.Model.swift
//  Banking MVVM
//
//  Created by Jean-Charles Mourey on 07/05/2024.
//

import Foundation

extension TransactionsView {
    @Observable class ViewModel {
        private(set) var account: Account
        private var accounts: [Account]
        
        private let storageController = StorageController()

        init(account: Account, accounts: [Account]) {
            self.account = account
            self.accounts = accounts
        }
        
        func addTransaction(withAmount amount: Int, beneficiary: String) {
            guard let index = accounts.firstIndex(where: { $0.id == account.id }) else { return }
            let transaction = Transaction(amount: amount, beneficiary: beneficiary, date: .now)
            account.add(transaction)
            accounts[index] = account
            storageController.save(accounts)
        }
    }
}
