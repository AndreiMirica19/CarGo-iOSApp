//
//  StarsView.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.03.2023.
//

import SwiftUI

struct StarsView: View {
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView()
    }
}
