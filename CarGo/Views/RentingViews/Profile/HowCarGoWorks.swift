//
//  HowCarGoWorks.swift
//  CarGo
//
//  Created by Andrei Mirica on 10.02.2023.
//

import SwiftUI

struct HowCarGoWorks: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("rentingBanner")
                .resizable()
                .frame(width: .infinity, height: 232)
            
            Spacer()
            
            HStack {
                Spacer()
                Text("How Car Go Works")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            
            HStack {
                Number(number: "1")
                VStack {
                    Text("Find the car you love")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("Search by location and date.After that, browse through the list of  available cars")
                        .multilineTextAlignment(.center)
                }
            }.padding()
            
            HStack {
                Number(number: "2")
                VStack {
                    Text("Book the car")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("Book the car and talk with the car owner.You can cancel for free up to 24h before your booking")
                        .multilineTextAlignment(.center)
                }
            }.padding()
            
            HStack {
                Number(number: "3")
                VStack {
                    Text("Hit the road")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("Pick up the car and enjoy your trip")
                        .multilineTextAlignment(.center)
                }
            }.padding()
            
            Spacer()
        }
    }
}

struct HowCarGoWorks_Previews: PreviewProvider {
    static var previews: some View {
        HowCarGoWorks()
    }
}
