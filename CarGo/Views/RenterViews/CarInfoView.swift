//
//  CarInfoView.swift
//  CarGo
//
//  Created by Andrei Mirica on 12.03.2023.
//

import SwiftUI
import MapKit

struct CarInfoView: View {
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 45.0, longitude: 25.0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    @StateObject var manager = LocationManager()
    
    var carInfo: CarInfoDTO
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Section {
                    Text("\(carInfo.manufacturer) \(carInfo.model)")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(carInfo.manufactureYear)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                
                Divider()
                    .padding(.bottom, 16)
                
                Section {
                    
                    HStack {
                        
                        Spacer()
                        
                        CarBasic(imageName: "car-seat", text: "\(carInfo.numberSeats) seats")
                        
                        Spacer()
                        
                        CarBasic(imageName: "manual-transmission", text: carInfo.transmission)
                        
                        Spacer()
                        
                        CarBasic(imageName: "fuel-pump", text: carInfo.fuel)
                        
                        Spacer()
                        
                    }
                    
                } header: {
                    Text("Car Basics")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Divider()
                    .padding(.bottom, 16)
                
                Section {
                    
                    Text(carInfo.description)
                    
                } header: {
                    Text("Descriptions")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Divider()
                    .padding(.bottom, 16)
                
                Section {
                    
                    Text("\(carInfo.street), \(carInfo.city), \(carInfo.country)")
                    
                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, annotationItems: manager.places) { place in
                        MapMarker(coordinate: place.location, tint: Color.red)
                    }
                    .frame(maxWidth: .infinity, idealHeight: 300)
                    .padding(.bottom)
                    .onReceive(manager.$region) { region in
                        self.region = region
                    }
                    .onReceive(manager.$updateRegionError) { error in
                        print(error as Any)
                    }
                } header: {
                    Text("Pickup location")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Divider()
                
            }.padding()
        }.padding()
            .onAppear {
                manager.updateLocation(address: "\(carInfo.street), \(carInfo.city), \(carInfo.country)")
            }
        
    }
}

struct CarInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CarInfoView(carInfo: CarInfoDTO(id: "", ownerId: "", numberPlate: "", manufacturer: "", model: "", carType: "", manufactureYear: "", transmission: "", color: "", fuel: "", numberSeats: "", description: "", street: "", city: "", country: "", photos: [], price: "", currency: "", discount: false))
    }
}
