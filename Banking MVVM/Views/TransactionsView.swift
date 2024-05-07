//
//  AccountView.swift
//  Banking (SwiftUI)
//
//  Created by Matteo Manferdini on 01/04/2020.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

struct TransactionsView: View {
    @State private var model: ViewModel
	@State private var addingTransaction: Bool = false
    
    init(account: Account, accounts: [Account]) {
        let model = ViewModel(account: account, accounts: accounts)
        self._model = State(initialValue: model)
    }
	
	var body: some View {
        Content(account: model.account, newTransaction: { addingTransaction = true })
			.sheet(isPresented: $addingTransaction) {
				NavigationStack {
                    NewTransactionView(account: model.account, add: model.addTransaction)
				}
		}
	}
}

// MARK: - Content
extension TransactionsView {
	struct Content: View {
		let account: Account
		let newTransaction: () -> Void
		
		var body: some View {
			VStack {
                List(transactions) { transaction in
					Row(transaction: transaction)
				}
				AddButton(title: "New Transaction", action: newTransaction)
			}
			.navigationBarTitle(account.name)
		}
		
		var transactions: [Transaction] {
            account.transactions.sorted(using: KeyPathComparator(\.date, order: .reverse))
		}
	}
}

// MARK: - Row
extension TransactionsView.Content {
	struct Row: View {
		let transaction: Transaction
		
		var body: some View {
			VStack(alignment: .leading, spacing: 4.0) {
				HStack {
					Text(transaction.beneficiary)
						.font(.headline)
					Spacer()
					Text(transaction.amount.currencyFormat)
						.font(.headline)
				}
				Text(transaction.date.transactionFormat)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
		}
	}
}

#Preview {
    NavigationStack {
        TransactionsView.Content(account: .preview, newTransaction: {})
    }
}
