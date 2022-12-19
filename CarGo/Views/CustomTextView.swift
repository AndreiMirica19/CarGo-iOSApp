//
//  CustomTextView.swift
//  CarGo
//
//  Created by Andrei Mirica on 19.12.2022.
//

import SwiftUI

struct CustomTextView: View {
    @Binding var text: String
    var imageName: String
    var placeHolder: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .padding(.leading)
            TextField(placeHolder, text: $text)
                .padding()
        }
        .background(.white)
        .cornerRadius(50)
        .padding()
    }
}

struct CustomTextView_Previews: PreviewProvider {

    static var previews: some View {
        CustomTextView(text: .constant("D"), imageName: "mail", placeHolder: "name")
    }
}
