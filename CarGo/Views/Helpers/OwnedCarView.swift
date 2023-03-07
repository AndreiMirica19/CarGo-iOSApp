//
//  OwnedCarView.swift
//  CarGo
//
//  Created by Andrei Mirica on 07.03.2023.
//

import SwiftUI

struct OwnedCarView: View {
    
    var carName: String
    var location: String
    var numberPlate: String
    var image: UIImage
    
    var body: some View {
        HStack {
            Image(uiImage: image)
                .resizable()
                .frame(width: 116, height: 116)
                .cornerRadius(16)
            
            VStack(alignment: .leading) {
                Text(carName)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)

                Text(location)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                
                Text(numberPlate)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }.padding()
                
        }
    }
}

struct OwnedCarView_Previews: PreviewProvider {
    static var previews: some View {
        OwnedCarView(carName: "Audi R8", location: "Bucuresti Sector 6", numberPlate: "B 32 WRT", image: UIImage())
    }
}
