//
//  CustomTextField.swift
//  CarGo
//
//  Created by Andrei Mirica on 08.02.2023.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        TextField(text: $text) {
            Text(placeholder)
        }
        .padding()
        .frame(height: 44)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
        })
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant("test"), placeholder: "PlaceHolder")
    }
}
