//
//  SymbolTextField.swift
//  CarGo
//
//  Created by Andrei Mirica on 20.03.2023.
//

import SwiftUI

struct SymbolTextField: View {
    @Binding var text: String
    var placeholder: String
    var image: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
            TextField(text: $text) {
                Text(placeholder)
            }
        }
        .padding()
        .frame(height: 44)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
        })
        .padding(.horizontal)
    }
}

struct SymbolTextField_Previews: PreviewProvider {
    static var previews: some View {
        SymbolTextField(text: .constant("address"), placeholder: "address", image: "map")
    }
}
