//
//  HowCarGoWorks.swift
//  CarGo
//
//  Created by Andrei Mirica on 10.02.2023.
//

import SwiftUI

struct HowCarGoWorks: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image("rentingBanner")
                    .resizable()
                    .frame(height: 232)
                
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
                    VStack(alignment: .leading) {
                        Text("Find the car you love")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("Search by location and date.After that, browse through the list of  available cars")
                            .multilineTextAlignment(.leading)
                    }
                }.padding()
                
                HStack {
                    Number(number: "2")
                    VStack(alignment: .leading) {
                        Text("Book the car")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("Book the car and talk with the car owner.You can cancel for free up to 24h before your booking")
                            .multilineTextAlignment(.leading)
                    }
                }.padding()
                
                HStack {
                    Number(number: "3")
                    VStack(alignment: .leading) {
                        Text("Hit the road")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("Pick up the car and enjoy your trip")
                            .multilineTextAlignment(.leading)
                    }
                }.padding()
                
                Spacer()
            }
        }
    }
}

struct HowCarGoWorks_Previews: PreviewProvider {
    static var previews: some View {
        HowCarGoWorks()
    }
}
