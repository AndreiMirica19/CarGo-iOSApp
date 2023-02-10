//
//  PorfileView.swift
//  CarGo
//
//  Created by Andrei Mirica on 25.01.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var isLoggedIn = false
    @State var isRoot = false
    @State var viewProfileDetails = false
    @State var userInfo: UserDetailsData?
    var profileViewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        if let userInfo = userInfo {
                            userInfo.profileImage.imageFromData()
                                .resizable()
                                .frame(width: 88, height: 88)
                                .clipShape(Circle())
                        } else {
                            EmptyProfileImage(height: 88, width: 88)
                        }
                        
                        VStack {
                            if let userInfo = userInfo {
                                Text(userInfo.name)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                            } else {
                                Text("Full name")
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }
                            
                            Button {
                                viewProfileDetails = true
                            } label: {
                                Text("View and edit profile")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        HStack {
                            Image(systemName: "person")
                            Text("Account")
                        }
                    }
                    
                    NavigationLink(destination: EmptyView()) {
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
                   // UserDefaults.standard.removeObject(forKey: "userId")
                   changeRootView()
                } label: {
                    Text("Logout")
                        .foregroundColor(.red)
                }
                .navigationDestination(isPresented: $viewProfileDetails) {
                    ProfileDetails(userInfo: $userInfo)
                }
                .onReceive(profileViewModel.$response, perform: { response in
                    guard let userDetails = response.0 else {
                        return
                    }
                    userInfo = userDetails
                })
                .onAppear {
                    profileViewModel.userInfo()
                }
            }
        }
    }
    
    func changeRootView() {
        let window = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        
        window?.rootViewController = UIHostingController(rootView: LoginView())
        window?.makeKeyAndVisible()
 
    }
}

struct PorfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
