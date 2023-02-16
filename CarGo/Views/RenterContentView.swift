//
//  RenterContentView.swift
//  CarGo
//
//  Created by Andrei Mirica on 16.02.2023.
//

import SwiftUI

struct RenterContentView: View {
    var body: some View {
        TabView {
            
            PerformanceView()
                .tabItem {
                    Label("Performance", systemImage: "speedometer")
                }
            
            MyBookingsView()
                .tabItem {
                    Label("My cars", systemImage: "car.2")
                }
            
            MyBookingsView()
                .tabItem {
                    Label("Bookings", systemImage: "calendar.circle")
                }
            
            ProfileContentView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

struct RenterContentView_Previews: PreviewProvider {
    static var previews: some View {
        RenterContentView()
    }
}
