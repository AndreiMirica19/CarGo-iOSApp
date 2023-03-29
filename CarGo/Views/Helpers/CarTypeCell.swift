//
//  CarTypeCell.swift
//  CarGo
//
//  Created by Andrei Mirica on 23.03.2023.
//

import SwiftUI

struct CarTypeCell: View {
    var car: String
    var isSelected = false
    var carTapped: (() -> Void)
    
    var body: some View {
        VStack {
            Image(car)
                .resizable()
                .frame(width: 40, height: 40)
            
            Text(car)
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
            carTapped()
        }
    }
}

struct CarTypeCell_Previews: PreviewProvider {
    static var previews: some View {
        CarTypeCell(car: "Supercar") {}
    }
}
