//
//  RentingContentView.swift
//  CarGo
//
//  Created by Andrei Mirica on 25.01.2023.
//

import SwiftUI

struct RentingContentView: View {

    var body: some View {
        TabView {
            
            SearchCarsView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle")
                }
            
            FavoriteCarsView()
                .tabItem {
                    Label("Favorite", systemImage: "heart.circle")
                }
            
            MyBookingsView()
                .tabItem {
                    Label("Bookings", systemImage: "calendar.circle")
                }
            
            ProfileContentView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }.navigationBarBackButtonHidden()
    }
}

struct RentingContentView_Previews: PreviewProvider {
    static var previews: some View {
        RentingContentView()
    }
}
