//
//  ViewProfile.swift
//  CarGo
//
//  Created by Andrei Mirica on 02.02.2023.
//

import SwiftUI

struct ProfileDetails: View {
    @State var editProfile = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 128, height: 128)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                            
                            Text("Full name")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                    }.listRowSeparator(.hidden)
                }
                
                Section {
                    Text("test")
                    
                } header: {
                    Text("About")
                        .fontWeight(.bold)
                }
                
                Section {
                    HStack {
                        Text("Country")
                        Spacer()
                        Text("Romania")
                    }
                    
                    HStack {
                        Text("City")
                        Spacer()
                        Text("Bucharest")
                    }
                    
                    HStack {
                        Text("Address")
                        Spacer()
                        Text("Adress")
                    }
                    
                    HStack {
                        Text("Phone number")
                        Spacer()
                        Text("094844848484849")
                    }
                    
                    HStack {
                        Text("Spoken languages")
                        Spacer()
                        Text("Romanian, English, French, Italian")
                    }
                    
                    HStack {
                        Text("Job")
                        Spacer()
                        Text("Programmer")
                    }
                } header: {
                    Text("Details")
                        .fontWeight(.bold)
                }
                .navigationDestination(isPresented: $editProfile) {
                    EditProfile()
                }
            }
            .listStyle(.plain)
            .toolbar {
                Button {
                    editProfile = true
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
    }
}

struct ViewProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetails()
    }
}
