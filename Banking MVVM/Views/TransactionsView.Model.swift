//
//  TransactionsView.Model.swift
//  Banking MVVM
//
//  Created by Jean-Charles Mourey on 07/05/2024.
//

import SwiftUI

extension TransactionsView {
    @Observable final class ViewModel {
        var account: Account
        private let update: (Account) -> Void
        
        init(account: Account, update: @escaping (Account) -> Void) {
            self.account = account
            self.update = update
        }
        
        func addTransaction(withAmount amount: Int, beneficiary: String) {
            let transaction = Transaction(amount: amount, beneficiary: beneficiary, date: .now)
            account.add(transaction)
            update(account)
        }
    }
}
