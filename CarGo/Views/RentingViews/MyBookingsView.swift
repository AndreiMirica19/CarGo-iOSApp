//
//  MyBookingsView.swift
//  CarGo
//
//  Created by Andrei Mirica on 25.01.2023.
//

import SwiftUI

struct MyBookingsView: View {
    @StateObject var myBookingsViewModel = MyBookingsViewModel()
    @State var alertIsPresent = false
    @State var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(myBookingsViewModel.getUpcomingBookings(), id: \.id) { booking in
                        NavigationLink {
                            BookingDetailsView(bookingInfo: booking)
                        } label: {
                            BookingCardView(bookingInfo: booking)
                        }
                    }
                } header: {
                    Text("Upcoming bookings")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.headline)
                }
                
                Section {
                    ForEach(myBookingsViewModel.getCompletedBookings(), id: \.id) { booking in
                        
                        NavigationLink {
                            BookingDetailsView(bookingInfo: booking)
                        } label: {
                            BookingCardView(bookingInfo: booking)
                        }
                        
                    }
                } header: {
                    Text("Past bookings")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.headline)
                }
            }.onAppear {
                myBookingsViewModel.userBookings()
            }
            .onReceive(myBookingsViewModel.$myBookingsResponse) { response in
                guard let error = response.1 else {
                    return
                }
                
                errorMessage = error.getErrorMessage()
                alertIsPresent = true
            }
            .alert(errorMessage, isPresented: $alertIsPresent) {
                Button("Ok", role: .cancel) {
                    
                }
            }
        }
    }
}

struct MyBookingsView_Previews: PreviewProvider {
    static var previews: some View {
        MyBookingsView()
    }
}
