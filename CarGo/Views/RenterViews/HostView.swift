//
//  HostView.swift
//  CarGo
//
//  Created by Andrei Mirica on 16.03.2023.
//

import SwiftUI

struct HostView: View {
    var body: some View {
        List {
            Section {
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
                            
                            StarsView()
                            
                            Button {
                                
                            } label: {
                                Text("View profile")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
            } header: {
                Text("The Host")
                    .font(.headline)
            }
            
            Section {
                ForEach(0...15, id: \.self) { _ in
                    ReviewView()
                }
            } header: {
                Text("Reviews")
                    .font(.headline)
            }
        }.listStyle(.insetGrouped)
    }
}

struct HostView_Previews: PreviewProvider {
    static var previews: some View {
        HostView()
    }
}
