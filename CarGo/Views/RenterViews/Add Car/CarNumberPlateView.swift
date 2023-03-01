//
//  CarNumberPlateView.swift
//  CarGo
//
//  Created by Andrei Mirica on 28.02.2023.
//

import SwiftUI

struct CarNumberPlateView: View {
    @Binding var numberPlate: String
    
    var body: some View {
        HStack {
            VStack(spacing: -4) {
                
                Image("europeanFlag")
                    .resizable()
                    .frame(width: 48, height: 48)
                    
                Text("RO")
                    .font(.title3)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.bottom)
                    
            }.background(Color("EuropeBlue"))
            
            TextField(text: $numberPlate) {}
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .textCase(.uppercase)
        }
        .frame(height: 72)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.black, lineWidth: 2)
        )
         .padding()

    }
}

struct CarNumberPlateView_Previews: PreviewProvider {
    static var previews: some View {
        CarNumberPlateView(numberPlate: .constant(""))
    }
}
