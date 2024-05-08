//
//  NewTransactionView.swift
//  Banking (SwiftUI)
//
//  Created by Matteo Manferdini on 01/04/2020.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

struct NewTransactionView: View {
	let account: Account
    let add: (Int, String) -> Void

    @Environment(\.dismiss) var dismiss
	@State private var amount: String = ""
	@State private var beneficiary: String = ""
	
	var body: some View {
        Content(amount: $amount, beneficiary: $beneficiary, cancel: { dismiss() }, send: send)
	}
	
	func send() {
        let amount = (Int(amount) ?? 0) * 100
        add(amount, beneficiary)
		dismiss()
	}
}

// MARK: - Content

extension NewTransactionView {
	struct Content: View {
		@Binding var amount: String
		@Binding var beneficiary: String
		
		let cancel: () -> Void
		let send: () -> Void
		
		var body: some View {
			List {
				Amount(amount: $amount)
				TextField("Beneficiary name", text: $beneficiary)
			}
			.navigationBarTitle("New Transaction")
			.navigationBarItems(leading: cancelButton, trailing: sendButton)
		}
		
		var cancelButton: some View {
			Button(action: cancel) {
				Text("Cancel")
			}
		}
		
		var sendButton: some View {
			Button(action: send) {
				Text("Send")
					.bold()
			}
		}
	}
}

extension NewTransactionView.Content {
	struct Amount: View {
		@Binding var amount: String
		
		var body: some View {
			VStack(alignment: .trailing) {
				Text("Amount")
					.font(.callout)
					.foregroundColor(.secondary)
				TextField(0.currencyFormat, text: $amount)
					.multilineTextAlignment(.trailing)
                    .keyboardType(.asciiCapableNumberPad)
					.font(Font.largeTitle.bold())
			}
			.padding()
		}
	}
}

#Preview {
    NavigationStack {
        NewTransactionView.Content(amount: .constant(""), beneficiary: .constant(""), cancel: {}, send: {})
    }
}
