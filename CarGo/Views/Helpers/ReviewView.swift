//
//  ReviewView.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.03.2023.
//

import SwiftUI

struct ReviewView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("porsche")
                    .resizable()
                    .frame(width: 88, height: 88)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("Full name")
                        .font(.headline)
                        .fontWeight(.bold)
                
                Text("Excellent host! The car was clean and well-maintained. Pickup and dropoff were a breeze. Would definitely recommend!")
                        .multilineTextAlignment(.leading)
                        .font(.subheadline)
                    StarsView()
                }
            }
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
