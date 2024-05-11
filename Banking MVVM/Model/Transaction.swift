//
//  Transaction.swift
//  Banking
//
//  Created by Matteo Manferdini on 28/01/2017.
//  Copyright © 2017 Pure Creek. All rights reserved.
//

import Foundation

struct Transaction: Identifiable, Codable, Hashable {
    let id: UUID
	let amount: Int
	let beneficiary: String
	let date: Date
    
    init(amount: Int, beneficiary: String, date: Date) {
        self.id = UUID()
        self.amount = amount
        self.beneficiary = beneficiary
        self.date = date
    }
}
