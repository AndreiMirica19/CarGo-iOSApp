//
//  HostProfileView.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.03.2023.
//

import SwiftUI

struct HostProfileView: View {
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Section {
                    Image("porsche")
                        .resizable()
                        .frame(width: 88, height: 88)
                        .clipShape(Circle())
                    
                    Text("Hi, I'm John Doe!")
                        .font(.headline)
                    
                    SymbolLabelView(symbolName: "star.fill", text: "5 stars", symbolColor: .yellow, textColor: .black)
                }
                
                Divider()
                
                Section {
                    Text("Welcome to my car sharing profile! As a car owner and host, I'm dedicated to providing the best experience for my guests. My car is always clean, well-maintained, and ready to hit the road. I take pride in being responsive and accommodating to your needs, whether it's a last-minute booking or a special reques")
                    
                    SymbolLabelView(symbolName: "house", text: "Lives in Bucharest, Romania", symbolColor: .black, textColor: .black)
                    
                    SymbolLabelView(symbolName: "bubble.left.and.bubble.right", text: "Speaks Romanian, English and French", symbolColor: .black, textColor: .black)
                    
                } header: {
                    Text("About")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                Divider()
                
                Section {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(0...5, id: \.self) { _ in
                                CarCardView()
                                    .frame(width: 248, height: 224)
                                    .padding()
                            }
                        }
                    }
                } header: {
                    Text("Doe's listings")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                Divider()
                
                Section {
                    ForEach(0...15, id: \.self) { _ in
                        ReviewView()
                        Divider()
                    }
                } header: {
                    Text("40 reviews")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
            }
            .frame(width: .infinity, alignment: .leading)
            .padding(.top, 16)
            .padding(.horizontal, 32)
        }
    }
}

struct HostProfileView_Previews: PreviewProvider {
    static var previews: some View {
        HostProfileView()
    }
}
