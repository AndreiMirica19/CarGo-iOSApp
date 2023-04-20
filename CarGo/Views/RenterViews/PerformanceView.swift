//
//  PerformanceView.swift
//  CarGo
//
//  Created by Andrei Mirica on 16.02.2023.
//

import SwiftUI

struct PerformanceView: View {
    @StateObject var hostStatsViewModel = HostStatsViewModel()
    @State var hostStats: HostStatsDTO?
    @State var errorAlertIsShown = false
    @State var errorMessage = ""
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    if let hostStats = hostStats {
                        Section {
                            Text("\(hostStats.totalEarnings)$")
                                .font(.title)
                                .fontWeight(.bold)
                        } header: {
                            Text("Total Earnings")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        
                        Divider()
                        
                        Section {
                            Text("\(hostStats.completedBookings)")
                                .font(.title)
                                .fontWeight(.bold)
                        } header: {
                            Text("Completed bookings")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        
                        Divider()
                        
                        Section {
                            StarsView()
                        } header: {
                            Text("Review rating")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        } footer: {
                            Text("Out of \(hostStats.numberOfReviews) reviews recived")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .fontWeight(.bold)
                        }
                        
                        Divider()
                        
                        Section {
                            if let carInfo = hostStats.mostBookedCar {
                                
                                NavigationLink {
                                    CarDetailsView(carData: carInfo)
                                } label: {
                                    CarInfoCardView(carInfo: carInfo, addedToFavorite: false, fromDate: nil, toDate: nil) {
                                    }.tint(.black)
                                }
                            }
                        } header: {
                            Text("Most booked car")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        
                        Divider()
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }.padding()
                .onAppear {
                    hostStatsViewModel.hostStats()
                }
                .onReceive(hostStatsViewModel.$hostStatsResponse) { response in
                    guard let hostStats = response.0 else {
                        guard let error = response.1 else {
                            return
                        }
                        
                        errorMessage = error.getErrorMessage()
                        errorAlertIsShown = true
                        return
                    }
                    self.hostStats = hostStats
                }
                .alert(errorMessage, isPresented: $errorAlertIsShown) {
                    Button("Ok", role: .cancel) {}
                }
        }
    }
}

struct PerformanceView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceView()
    }
}
