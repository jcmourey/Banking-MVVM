//
//  AddButton.swift
//  Banking (SwiftUI)
//
//  Created by Matteo Manferdini on 03/04/2020.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

struct AddButton: View {
	let title: String
	let action: () -> Void
	
	var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text(title)
            }
            .font(.headline)
        }
        .padding(.trailing, 20)
        .padding(.top, 10)
        .frame(maxWidth: .infinity, alignment: .trailing)
	}
}

#Preview {
    AddButton(title: "Add item", action: {})
        .frame(maxHeight: .infinity, alignment: .bottom)
}
