//
//  Formatting.swift
//  Budget
//
//  Created by Matteo Manferdini on 06/12/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import Foundation
import Algorithms

extension Int {
	var currencyFormat: String {
        (Double(self) / 100)
            .formatted(.currency())
	}
}

extension Date {
	var transactionFormat: String {
        formatted(date: .abbreviated, time: .omitted)
	}
}

extension String {
	var ibanFormat: String {
        chunks(ofCount: 4)
            .joined(separator: " ")
	}
}
