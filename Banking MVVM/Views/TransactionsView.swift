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
    
    init(account: Account, update: @escaping (Account) -> Void) {
        model = ViewModel(account: account, update: update)
    }
	
	var body: some View {
        Content(title: model.account.name, transactions: model.account.transactions, new: { addingTransaction = true })
			.sheet(isPresented: $addingTransaction) {
				NavigationStack {
                    New(account: model.account, add: model.addTransaction)
				}
                .presentationDetents([.fraction(0.3)]) 
                .interactiveDismissDisabled()
		}
	}
}

// MARK: - Content
extension TransactionsView {
	struct Content: View {
		let title: String
        let transactions: [Transaction]
		let new: () -> Void
		
		var body: some View {
			VStack {
                List(sortedTransactions) { transaction in
					Row(transaction: transaction)
				}
				AddButton(title: "New Transaction", action: new)
			}
			.navigationBarTitle(title)
		}

		var sortedTransactions: [Transaction] {
            transactions.sorted(using: KeyPathComparator(\.date, order: .reverse))
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
        TransactionsView(account: .preview, update: {_ in})
    }
}
