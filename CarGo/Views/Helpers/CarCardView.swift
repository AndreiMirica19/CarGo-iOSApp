//
//  CarCardView.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.03.2023.
//

import SwiftUI

struct CarCardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("porsche")
                .resizable()
                .cornerRadius(24.0)
                .scaledToFill()
                .frame(width: .infinity)

            Text("Manufacturer + model")
                .foregroundColor(.black)
                .font(.headline)
                .fontWeight(.bold)
                .frame(width: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("Year")
                .foregroundColor(.gray)
                .font(.headline)
                .fontWeight(.bold)
                .frame(width: .infinity, alignment: .leading)
                .padding(.horizontal)
        }.padding()
    }
}

struct CarCardView_Previews: PreviewProvider {
    static var previews: some View {
        CarCardView()
            .frame(width: 248, height: 224)
    }
}
