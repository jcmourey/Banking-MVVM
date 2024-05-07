//
//  Account.swift
//  Banking
//
//  Created by Matteo Manferdini on 28/01/2017.
//  Copyright © 2017 Pure Creek. All rights reserved.
//

import Foundation

struct Account: Codable {
	let name: String
	let iban: String
	let kind: Kind
	private(set) var transactions: [Transaction]
		
    var balance: Int { transactions.map(\.amount).reduce(0, +) }

	init(name: String, iban: String, kind: Kind) {
		self.name = name
		self.kind = kind
		self.iban = iban
        transactions = [ Transaction(amount: 2000_00, beneficiary: "Initial Balance", date: .now) ]
	}
	
	mutating func add(_ transaction: Transaction) {
		transactions.append(transaction)
	}
}

extension Account: Identifiable {
    var id: String { iban }
}

extension Account: Hashable {
    static func == (lhs: Account, rhs: Account) -> Bool {
        lhs.name == rhs.name &&
        lhs.iban == rhs.iban &&
        lhs.kind == rhs.kind
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(iban)
        hasher.combine(kind)
    }
}

extension Account {
	enum Kind: String, Codable, CaseIterable {
		case checking
		case savings
		case investment
	}
}
