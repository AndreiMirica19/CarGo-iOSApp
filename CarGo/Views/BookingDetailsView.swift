//
//  BookingDetailsView.swift
//  CarGo
//
//  Created by Andrei Mirica on 18.04.2023.
//

import SwiftUI
import MapKit

struct BookingDetailsView: View {
    
    var bookingInfo: BookingInfo
    
    @StateObject var manager = LocationManager()
    @StateObject var bookingDetailsViewModel = BookingDetailsViewModel()
    @State var cancelConfirmationAlertIsShown = false
    @State var statusChangedAlertIsShown = false
    @State var errorAlertIsShown = false
    @State var errorMessage = ""
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 45.0, longitude: 25.0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Section {
                    HStack {
                        Text("From: \(bookingInfo.fromDate.localTimezoneDateString())")
                            .font(.body)
                            .fontWeight(.medium)
                    }
                    
                    HStack {
                        Text("To: \(bookingInfo.toDate.localTimezoneDateString())")
                            .font(.body)
                            .fontWeight(.medium)
                    }.padding(.top, 2)
                    
                    HStack {
                        Text("Price: \(bookingInfo.totalPrice())$")
                            .font(.body)
                            .fontWeight(.medium)
                        
                    }.padding(.top, 2)
                }
                
                Divider()
                
                Section {
                    Text("\(bookingInfo.carInfo.fullAddress())")
                    
                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, annotationItems: manager.places) { place in
                        MapMarker(coordinate: place.location, tint: Color.red)
                    }
                    .frame(maxWidth: .infinity, idealHeight: 300)
                    .padding(.bottom)
                    
                } header: {
                    Text("Pickup Address")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Divider()
                
                Section {
                    NavigationLink {
                        CarDetailsView(carData: bookingInfo.carInfo)
                    } label: {
                        CarCardView(carInfo: bookingInfo.carInfo)
                    }
                    
                } header: {
                    Text("Car Info")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Divider()
                
                Section {
                    
                    NavigationLink {
                        HostProfileView(hostInfo: bookingInfo.hostInfo)
                    } label: {
                        VStack(alignment: .center) {
                            if let profilePictureImage = UIImage(data: bookingInfo.hostInfo.hostDetails.profileImage) {
                                Image(uiImage: profilePictureImage)
                                    .resizable()
                                    .frame(width: 88, height: 88)
                                    .clipShape(Circle())
                            }
                            
                            Text("Hi, I'm \(bookingInfo.hostInfo.hostDetails.name)!")
                                .font(.headline)
                                .foregroundColor(.black)
                            
                            SymbolLabelView(symbolName: "star.fill", text: "5 stars", symbolColor: .yellow, textColor: .black)
                        }.frame(maxWidth: .infinity)
                    }
                } header: {
                    Text("Host Info")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Divider()
                
                if !UserRepository.shared.isRenterViewActive && bookingInfo.status != BookingStatus.cancelled.rawValue {
                    HStack {
                        Spacer()
                        
                        Button {
                            let status = BookingStatus(rawValue: bookingInfo.getStatus())
                            
                            switch status {
                            case .cancelled, .hostCancelled, .completed, .none:
                                return

                            case .pending, .accepted:
                                cancelConfirmationAlertIsShown = true
                                
                            case .inProgress:
                                bookingDetailsViewModel.changeBookingStatus(bookingId: bookingInfo.id, status: BookingStatus.completed.rawValue)
                                
                            }
                           
                        } label: {
                            let status = BookingStatus(rawValue: bookingInfo.getStatus())
                            
                            switch status {
                            case .cancelled, .hostCancelled, .completed, .none:
                                EmptyView()
                                
                            case .pending, .accepted:
                                Text("Cancel booking")
                            
                            case .inProgress:
                                Text("Finish booking")
                            }
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
              
                        Spacer()
                    }
                } else {
                    if UserRepository.shared.isRenterViewActive && bookingInfo.status == BookingStatus.pending.rawValue {
                        
                        HStack {
                            Button {
                                bookingDetailsViewModel.changeBookingStatus(bookingId: bookingInfo.id, status: BookingStatus.accepted.rawValue)
                            } label: {
                                Text("Accept booking")
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Spacer()
                            
                            Button {
                                cancelConfirmationAlertIsShown = true
                            } label: {
                                Text("Cancel booking")
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                        }
                    }
                }
            }
            .padding()
            
        }
        .navigationTitle(Text("Booking Info"))
            .onAppear {
                manager.updateLocation(address: bookingInfo.carInfo.fullAddress())
            }
            .onReceive(manager.$region) { region in
                self.region = region
            }
            .onReceive(manager.$updateRegionError) { error in
                print(error as Any)
            }
            .alert("Cancel Booking", isPresented: $cancelConfirmationAlertIsShown) {
                Button("Yes", role: .cancel) {
                    bookingDetailsViewModel.changeBookingStatus(bookingId: bookingInfo.id, status: UserRepository.shared.isRenterViewActive ? BookingStatus.hostCancelled.rawValue : BookingStatus.cancelled.rawValue)
                }
            }
            .onReceive(bookingDetailsViewModel.$bookingStatusResponse) { response in
                guard let statusChangedResponse = response.0 else {
                    guard let errorResponse = response.1 else {
                        return
                    }
                    
                    errorAlertIsShown = true
                    errorMessage = errorResponse.getErrorMessage()
                    return
                }
                
                if statusChangedResponse.statusCode == 200 {
                    statusChangedAlertIsShown = true
                } else {
                    errorAlertIsShown = true
                    errorMessage = statusChangedResponse.message
                }
            }
            .alert("Status changed", isPresented: $statusChangedAlertIsShown) {
                Button("Ok", role: .cancel) {}
            }
            .alert(errorMessage, isPresented: $errorAlertIsShown) {
                Button("Ok", role: .cancel) {}
            }
    }
}

struct BookingDetailsView_Previews: PreviewProvider {
    
    static var carInfo = CarInfoDTO(id: "car456", ownerId: "owner789", numberPlate: "ABC-123", manufacturer: "Tesla", model: "Model S", carType: "Sedan", manufactureYear: "2021", transmission: "Automatic", color: "White", fuel: "Electric", numberSeats: "5", description: "This car is amazing! It's fast, quiet, and has all the latest technology.", street: "123 Main Street", city: "New York", country: "United States", photos: [Data(), Data(), Data()], price: "100.00", currency: "USD", discount: false)
    
    static var previews: some View {
        BookingDetailsView(bookingInfo: BookingInfo(toDate: "2023-05-01", status: "Pending", renterDetails: UserDetailsData(name: "John Doe", about: "I'm a traveler and I love exploring new places!", country: "United States", city: "New York", job: "Software Engineer", profileImage: Data(), spokenLanguages: ["English", "Spanish"], favoriteCars: []), id: "booking123", carInfo: carInfo, fromDate: "2023-04-29", hostInfo: HostInfoDTO(hostDetails: UserDetailsData(name: "Jane Smith", about: "I'm a car enthusiast and I love sharing my passion with others!", country: "United States", city: "Los Angeles", job: "Marketing Manager", profileImage: Data(), spokenLanguages: ["English", "French"], favoriteCars: []), ownedCars: [], reviews: [])))
    }
}
