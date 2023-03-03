//
//  CustomInputView.swift
//  CarGo
//
//  Created by Andrei Mirica on 02.03.2023.
//

import SwiftUI

struct CustomInputView: View {
    @FocusState private var fieldIsFocused: Bool
    @Binding  var text: String
    var label: String
    var onCommit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(fieldIsFocused ? .purple : .black)
            
            TextField("", text: $text)
            .focused($fieldIsFocused)
            .onChange(of: fieldIsFocused) { isFocused in
                if !isFocused {
                    onCommit()
                }
            }
            Divider()
                .overlay(fieldIsFocused ? .purple : .gray)
        }
    }
}

struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputView(text: .constant("Test"), label: "Test") {
            
        }
    }
}
