//
//  BankingApp.swift
//  Banking (SwiftUI)
//
//  Created by Jean-Charles Mourey on 07/05/2024.
//  Copyright © 2024 Matteo Manferdini. All rights reserved.
//

import SwiftUI
import SwiftUI

@main
struct BankingApp: App {
    let storageController = StorageController()
    
    var body: some Scene {
        WindowGroup {
            AccountsView()
        }
    }
}
