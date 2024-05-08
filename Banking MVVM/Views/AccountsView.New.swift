//
//  NewAccountView.swift
//  Banking (SwiftUI)
//
//  Created by Matteo Manferdini on 01/04/2020.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

extension AccountsView {
    struct New: View {
        let add: (String, Account.Kind) -> Void
        
        @Environment(\.dismiss) var dismiss
        @State private var name: String = ""
        @State private var kind: Account.Kind = .checking
        
        var body: some View {
            Content(name: $name, kind: $kind, create: create, cancel: dismiss.callAsFunction)
        }
        
        func create() {
            add(name, kind)
            dismiss()
        }
    }
}

// MARK: - Content
extension AccountsView.New {
    struct Content: View {
        @Binding var name: String
        @Binding var kind: Account.Kind
        
        let create: () -> Void
        let cancel: () -> Void
        
        var body: some View {
            Form {
                TextField("Account name", text: $name)
                Picker("Kind", selection: $kind) {
                    ForEach(Account.Kind.allCases, id: \.self) { kind in
                        Text(kind.rawValue).tag(kind)
                    }
                }
                .pickerStyle(.inline)
            }
            .navigationBarTitle("New Account")
            .navigationBarItems(leading: cancelButton, trailing: createButton)
        }
        
        var cancelButton: some View {
            Button(action: cancel) {
                Text("Cancel")
            }
        }
        
        var createButton: some View {
            Button(action: create) {
                Text("Create")
                    .bold()
            }
        }
    }
}

#Preview {
    NavigationStack {
        AccountsView.New.Content(name: .constant(""), kind: .constant(.checking), create: {}, cancel: {})
    }
}
