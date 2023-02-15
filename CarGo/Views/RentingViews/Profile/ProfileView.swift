//
//  PorfileView.swift
//  CarGo
//
//  Created by Andrei Mirica on 25.01.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var router: Router<ProfilePaths>
    @State var isLoggedIn = false
    @State var isRoot = false
    @State var viewProfileDetails = false
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        List {
            Section {
                HStack {
                    if let userInfo = profileViewModel.response.0 {
                        userInfo.profileImage.imageFromData()
                            .resizable()
                            .frame(width: 88, height: 88)
                            .clipShape(Circle())
                    } else {
                        EmptyProfileImage(height: 88, width: 88)
                    }
                    
                    VStack {
                        if let accountInfo = profileViewModel.accountResponse.0 {
                            Text(accountInfo.name)
                                .font(.headline)
                                .fontWeight(.bold)
                            
                        } else {
                            Text("Full name")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        
                        Button {
                            router.push(.profileDetails)
                        } label: {
                            Text("View and edit profile")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                    }
                }
                
                NavigationLink(destination: AccountInfo().environmentObject(profileViewModel)) {
                    HStack {
                        Image(systemName: "person")
                        Text("Account")
                    }
                }

                NavigationLink(destination: HowCarGoWorks()) {
                    HStack {
                        Image(systemName: "car")
                        Text("How CarGo works")
                    }
                }
                
                NavigationLink {
                    EmptyView()
                } label: {
                    Image(systemName: "message")
                    Text("Contact support")
                }
                
                NavigationLink {
                    TermsAndConditions()
                } label: {
                    HStack {
                        Image(systemName: "newspaper")
                        Text("Terms and conditions")
                    }
                }
                
                Button {
                    
                } label: {
                    Text("Switch to renter")
                }
            }
            
            Button {
                UserRepository.shared.logout()
            } label: {
                Text("Logout")
                    .foregroundColor(.red)
            }
            .onAppear {
                profileViewModel.userInfo()
                profileViewModel.accountInfo()
            }
        }
    }
}

struct PorfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
