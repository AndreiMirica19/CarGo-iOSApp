//
//  AddCarLocation.swift
//  CarGo
//
//  Created by Andrei Mirica on 02.03.2023.
//

import SwiftUI
import MapKit

struct AddCarLocation: View {
    
    @EnvironmentObject var router: Router<AddCarPaths>
    @EnvironmentObject var carData: CarData
    @State private var street = ""
    @State private var city = ""
    @State private var country = ""
    @StateObject var manager = LocationManager()
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 45.0, longitude: 25.0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Section {
                    Text("Car location")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                        .padding(.top)
                    
                    Text("Please complete the following fields with the pick-up address.")
                        .font(.subheadline)
                }
                Spacer()
                
                CustomInputView(text: $street, label: "Street name & number") {
                    updateLocation()
                }
                
                CustomInputView(text: $city, label: "City", onCommit: { updateLocation() })
                
                CustomInputView(text: $country, label: "Country", onCommit: { updateLocation() })
                
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, annotationItems: manager.places) { place in
                    MapMarker(coordinate: place.location, tint: Color.red)
                }
                .frame(maxWidth: .infinity, idealHeight: 300)
                .padding(.bottom)
                
                Button {
                    carData.street = street
                    carData.city = city
                    carData.country = country
                    router.push(.addCarPhotos)
                } label: {
                    Text("Next")
                }
                .padding()
                .cornerRadius(8)
                .buttonStyle(OutlineBorder(color: checkFormCompletion() ? .blue : .gray))
                .disabled(!checkFormCompletion())
                
            }.padding(.horizontal, 24)
                .onReceive(manager.$region) { region in
                    self.region = region
                }
                .onReceive(manager.$updateRegionError) { error in
                    print(error as Any)
                }
        }.padding(.top)
    }
    
    func checkAdress() -> Bool {
        return street.count > 3 && city.count > 3 && country.count > 3
    }
    
    func updateLocation() {
        if checkAdress() {
            let address = "\(street), \(city), \(country)"
            manager.updateLocation(address: address)
        }
    }
    
    func checkFormCompletion() -> Bool {
        !street.isEmpty && !city.isEmpty && !country.isEmpty
    }
    
}

struct AddCarLocation_Previews: PreviewProvider {
    static var previews: some View {
        AddCarLocation()
    }
}
