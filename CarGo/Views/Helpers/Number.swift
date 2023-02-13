//
//  Number.swift
//  CarGo
//
//  Created by Andrei Mirica on 10.02.2023.
//

import SwiftUI

struct Number: View {
    var number: String
    var body: some View {
        Text(number)
            .padding()
            .overlay {
                Circle()
                    .stroke()
            }
    }
}

struct Number_Previews: PreviewProvider {
    static var previews: some View {
        Number(number: "1")
    }
}
