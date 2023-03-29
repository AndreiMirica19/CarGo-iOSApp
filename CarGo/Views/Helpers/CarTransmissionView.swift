//
//  CarTransmissionView.swift
//  CarGo
//
//  Created by Andrei Mirica on 29.03.2023.
//

import SwiftUI

struct CarTransmissionView: View {
    
    var image: String
    var text: String
    var isSelected: Bool
    var transmissionTapped: (() -> Void)

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .frame(width: 40, height: 40)
            
            Text(text)
                .foregroundColor(.black)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 2)
        )
        .background(isSelected ? Color.teal.opacity(0.3) : .white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            transmissionTapped()
        }

    }
}

struct CarTransmissionView_Previews: PreviewProvider {
    static var previews: some View {
        CarTransmissionView(image: "automatic-transmission", text: "automatic", isSelected: false) {
            
        }
    }
}
