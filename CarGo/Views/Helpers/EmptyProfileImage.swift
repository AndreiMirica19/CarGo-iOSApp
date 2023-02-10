//
//  ProfileImage.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import SwiftUI

struct EmptyProfileImage: View {
    var height: Int
    var width: Int
    var body: some View {
        Image(systemName: "person.circle")
            .resizable()
            .frame(width: 128, height: 128)
            .foregroundColor(.gray)
            .clipShape(Circle())
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        EmptyProfileImage(height: 88, width: 88)
    }
}
