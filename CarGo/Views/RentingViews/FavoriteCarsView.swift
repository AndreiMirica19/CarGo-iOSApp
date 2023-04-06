//
//  FavoriteCarsView.swift
//  CarGo
//
//  Created by Andrei Mirica on 25.01.2023.
//

import SwiftUI

struct FavoriteCarsView: View {
    @StateObject var favoriteCarsViewModel = FavoriteCarsViewModel()
    @State var favoriteCars: [CarInfoDTO] = []
    @State var errorMessage = ""
    @State var isErrorShown = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(favoriteCars, id: \.id) { car in
                        
                        ZStack {
                            NavigationLink {
                                CarDetailsView(carData: car)
                            } label: {
                                EmptyView().opacity(0.0)
                                
                            }
                            
                            CarInfoCardView(carInfo: car, addedToFavorite: favoriteCars.contains(where: { carID in
                                return carID.id == car.id
                            })) {
                                favoriteCarsViewModel.toggleFavoriteCar(carId: car.id)
                            }
                            
                        }.padding()
                        
                    }

                } header: {
                    Text("Favorite cars")
                        .foregroundColor(.black)
                        .font(.title)
                        .fontWeight(.bold)
                }.listSectionSeparator(.hidden)
            }
            .listStyle(.grouped)
            .padding(.top, 2)
            .onAppear {
                favoriteCarsViewModel.favoriteCars()
            }
            .onReceive(favoriteCarsViewModel.$favoriteCarToggledResponse) { response in
                guard let cars = response.0 else {
                    guard let error = response.1 else {
                        return
                    }
                    
                    self.errorMessage = error.getErrorMessage()
                    self.isErrorShown = true
                    return
                }
                
                self.favoriteCars = cars
            }
            .onReceive(favoriteCarsViewModel.$favoriteCarsResponse) { response in
                guard let cars = response.0 else {
                    guard let error = response.1 else {
                        return
                    }
                    
                    self.errorMessage = error.getErrorMessage()
                    self.isErrorShown = true
                    return
                }
                
                favoriteCars = cars
            }
        }
    }
}

struct FavoriteCarsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCarsView()
    }
}
