//
//  Numbers.swift
//  Banking MVVM
//
//  Created by Jean-Charles Mourey on 08/05/2024.
//

import Foundation

// Default Swift implementation of Double(_ string:) only accepts "." as decimal separator (incredibly!)
// Make it locale specific
extension Double {
    init?(_ string: String) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        guard let number = formatter.number(from: string) else { return nil }
        
        self = number.doubleValue
    }
}

// Extend currency(_ code:) to use current Locale's currency if none specified
// (should be default behavior!)
extension FormatStyle {
    public static func currency<Value>() -> Self where Self == FloatingPointFormatStyle<Value>.Currency, Value : BinaryFloatingPoint {
        currency(code: Locale.current.currency?.identifier ?? "USD")
    }
}

