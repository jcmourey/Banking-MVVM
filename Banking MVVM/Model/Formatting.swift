//
//  Formatting.swift
//  Budget
//
//  Created by Matteo Manferdini on 06/12/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import Foundation

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
        inserted(" ", atEach: 4)
	}
    
    func inserted(_ newElement: Character, atEach increment:Int)->String {
        var newStr = self

        for indx in stride(from: increment, to: newStr.count, by: increment).reversed() {
            let index = String.Index(utf16Offset: indx, in: newStr)
            newStr.insert(newElement, at: index)
        }

        return newStr
    }
}
