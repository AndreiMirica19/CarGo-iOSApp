//
//  SymbolTextField.swift
//  CarGo
//
//  Created by Andrei Mirica on 20.03.2023.
//

import SwiftUI

struct SymbolTextField: View {
    var text: String
    var placeholder: String
    var image: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
            Text("\(text.isEmpty ? placeholder : text)")
                .foregroundColor(text.isEmpty ? .gray : .black)
            Spacer()
        }
        .frame(maxWidth: .infinity)
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
        SymbolTextField(text: ("address"), placeholder: "address", image: "map")
    }
}
