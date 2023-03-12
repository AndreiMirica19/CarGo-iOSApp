//
//  CarBasic.swift
//  CarGo
//
//  Created by Andrei Mirica on 12.03.2023.
//

import SwiftUI

struct CarBasic: View {
    var imageName: String
    var text: String
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 32, height: 32)
            
            Text(text)
        }
    }
}

struct CarBasic_Previews: PreviewProvider {
    static var previews: some View {
        CarBasic(imageName: "car-seat", text: "4 seats")
    }
}
