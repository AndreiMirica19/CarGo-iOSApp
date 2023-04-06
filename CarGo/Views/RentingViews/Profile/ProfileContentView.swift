//
//  ProfileContentView.swift
//  CarGo
//
//  Created by Andrei Mirica on 10.02.2023.
//

import SwiftUI

struct ProfileContentView: View {
    @ObservedObject var router = Router<ProfilePaths>()
    @ObservedObject var profileViewModel = ProfileViewModel()
    @State var displayError = false
    @State var errorMessage = ""

    var body: some View {
        NavigationStack(path: $router.paths) {
            ProfileView()
                .navigationDestination(for: ProfilePaths.self) { path in
                    switch path {
                    case .profileView:
                        ProfileView()
                        
                    case .profileDetails:
                        ProfileDetails().environmentObject(router)
                            .environmentObject(profileViewModel)
                        
                    case .editProfile:
                        EditProfile().environmentObject(profileViewModel)
                        
                    case .account:
                        Text("Accout")
                    }
                }
                .environmentObject(router)
                .environmentObject(profileViewModel)
                .onReceive(profileViewModel.$userDetailsResponse) { response in
                    if let errorResponse = response.1 {
                        displayError = true
                        errorMessage = errorResponse.getErrorMessage()
                    }
                }
                .alert(errorMessage, isPresented: $displayError) {
                    Button("Ok", role: .cancel) {
                    }
                }
        }
    }
    
    init() {
        profileViewModel.userInfo()
        profileViewModel.accountInfo()
    }
}

struct ProfileContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContentView()
    }
}
