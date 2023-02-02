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
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 88, height: 88)
                        
                        VStack {
                            Text("Full name")
                                .font(.headline)
                                .fontWeight(.bold)
                            
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
                    ProfileDetails()
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
