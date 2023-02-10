//
//  IncompleteProfile.swift
//  CarGo
//
//  Created by Andrei Mirica on 10.02.2023.
//

import SwiftUI

struct IncompleteProfile: View {
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.badge.exclamationmark")
                .resizable()
                .frame(width: 128, height: 128)
            
            Text("Please complete the profile by pressing on the top right button")
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
    }
}

struct IncompleteProfile_Previews: PreviewProvider {
    static var previews: some View {
        IncompleteProfile()
    }
}
