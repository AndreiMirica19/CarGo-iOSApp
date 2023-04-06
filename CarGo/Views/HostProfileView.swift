//
//  HostProfileView.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.03.2023.
//

import SwiftUI

struct HostProfileView: View {
    var hostInfo: HostInfoDTO
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Section {

                    if let profilePictureImage = UIImage(data: hostInfo.hostDetails.profileImage) {
                            Image(uiImage: profilePictureImage)
                            .resizable()
                            .frame(width: 88, height: 88)
                            .clipShape(Circle())
                        }

                    Text("Hi, I'm \(hostInfo.hostDetails.name)!")
                        .font(.headline)
                    
                    SymbolLabelView(symbolName: "star.fill", text: "5 stars", symbolColor: .yellow, textColor: .black)
                }
                
                Divider()
                
                Section {
                    Text(hostInfo.hostDetails.about)
                    
                    SymbolLabelView(symbolName: "house", text: "Lives in \(hostInfo.hostDetails.city), \(hostInfo.hostDetails.country)", symbolColor: .black, textColor: .black)
                    
                    SymbolLabelView(symbolName: "bubble.left.and.bubble.right", text: "Speaks \(hostInfo.hostDetails.spokenLanguages.joined(separator: ", "))", symbolColor: .black, textColor: .black)
                    
                } header: {
                    Text("About")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                Divider()
                
                Section {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(hostInfo.ownedCars, id: \.id) { car in
                                CarCardView(carInfo: car)
                                    .frame(width: 248, height: 224)
                                    .padding()
                            }
                        }
                    }
                } header: {
                    Text("\(hostInfo.hostDetails.name)'s listings")
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
        HostProfileView(hostInfo: HostInfoDTO(hostDetails: UserDetailsData(name: "", about: "", country: "", city: "", job: "", profileImage: Data(), spokenLanguages: [], favoriteCars: []), ownedCars: [], reviews: []))
    }
}
