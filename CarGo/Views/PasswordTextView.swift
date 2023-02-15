//
//  PasswordTextView.swift
//  CarGo
//
//  Created by Andrei Mirica on 19.12.2022.
//

import SwiftUI

struct PasswordTextView: View {
    @Binding var text: String
    var placeHolder: String

    var body: some View {
        HStack {
            Image(systemName: "lock")
                .padding(.leading)
            SecureField(placeHolder, text: $text)
                .padding()
        }
        .background(.white)
        .cornerRadius(50)
    }
}

struct PasswordTextView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextView(text: .constant("Passowrd"), placeHolder: "test")
    }
}
