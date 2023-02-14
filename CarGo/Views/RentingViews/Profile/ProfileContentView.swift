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
    @Binding var loginSuccessful: Bool
    @State var displayError = false
    @State var errorMessage = ""

    var body: some View {
        NavigationStack(path: $router.paths) {
            ProfileView(loginSuccessful: $loginSuccessful)
                .navigationDestination(for: ProfilePaths.self) { path in
                    switch path {
                    case .profileView:
                        ProfileView(loginSuccessful: $loginSuccessful)
                        
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
                .onReceive(profileViewModel.$response) { response in
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
    
    init(loginSuccessful: Binding<Bool>) {
        _loginSuccessful = loginSuccessful
        profileViewModel.userInfo()
        profileViewModel.accountInfo()
    }
}

struct ProfileContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContentView(loginSuccessful: .constant(false))
    }
}
