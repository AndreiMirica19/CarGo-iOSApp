//
//  ViewProfile.swift
//  CarGo
//
//  Created by Andrei Mirica on 02.02.2023.
//

import SwiftUI

struct ProfileDetails: View {
    @State var editProfile = false
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var router: Router<ProfilePaths>
    
    var body: some View {
            VStack {
                if let userInfo = profileViewModel.response.0, let accountInfo = profileViewModel.accountResponse.0 {
                    List {
                        Section {
                            HStack {
                                Spacer()
                                VStack(alignment: .center) {
                                    userInfo.profileImage.imageFromData()
                                        .resizable()
                                        .frame(width: 128, height: 128)
                                        .clipShape(Circle())
                                    
                                    Text(accountInfo.name)
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
                    }
                    .listStyle(.plain)
                } else {
                    IncompleteProfile()
                }
            }.toolbar {
                Button {
                    router.push(.editProfile)
                } label: {
                    Image(systemName: "pencil")
                }
            }
            .onAppear {
                profileViewModel.userInfo()
                profileViewModel.accountInfo()
            }
        }
}

struct ViewProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetails()
    }
}
