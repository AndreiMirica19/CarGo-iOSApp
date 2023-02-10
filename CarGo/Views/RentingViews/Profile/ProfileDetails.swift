//
//  ViewProfile.swift
//  CarGo
//
//  Created by Andrei Mirica on 02.02.2023.
//

import SwiftUI

struct ProfileDetails: View {
    @State var editProfile = false
    @Binding var userInfo: UserDetailsData?
    
    var body: some View {
        NavigationStack {
            VStack {
                if let userInfo = userInfo {
                    List {
                        Section {
                            HStack {
                                Spacer()
                                VStack(alignment: .center) {
                                    userInfo.profileImage.imageFromData()
                                        .resizable()
                                        .frame(width: 128, height: 128)
                                        .clipShape(Circle())
                                    
                                    Text(userInfo.name)
                                        .font(.title)
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                            }.listRowSeparator(.hidden)
                        }
                        
                        Section {
                            Text(userInfo.about)
                            
                        } header: {
                            Text("About")
                                .fontWeight(.bold)
                        }
                        
                        Section {
                            HStack {
                                Text("Country")
                                Spacer()
                                Text(userInfo.country)
                            }
                            
                            HStack {
                                Text("City")
                                Spacer()
                                Text(userInfo.city)
                            }
                            
                            HStack {
                                Text("Spoken languages")
                                Spacer()
                                Text(userInfo.spokenLanguages.joined(separator: ", "))
                            }
                            
                            HStack {
                                Text("Job")
                                Spacer()
                                Text(userInfo.job)
                            }
                        } header: {
                            Text("Details")
                                .fontWeight(.bold)
                        }
                        .navigationDestination(isPresented: $editProfile) {
                            EditProfile(userInfo: $userInfo)
                        }

                    }
                    .listStyle(.plain)
                } else {
                    IncompleteProfile()
                }
            }.toolbar {
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
        ProfileDetails(userInfo: .constant(nil))
    }
}
