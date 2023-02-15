//
//  AccountInfo.swift
//  CarGo
//
//  Created by Andrei Mirica on 13.02.2023.
//

import SwiftUI

struct AccountInfo: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State var deleteAccountAlert = false
    @State var deleteSuccessfulAlert = false
    @State var errorAlert = false
    @State var errorMessage = ""
    
    var body: some View {
        List {
            if let accountInfo = profileViewModel.accountResponse.0 {
                NavigationLink(destination: ChangeEmail().environmentObject(profileViewModel)) {
                    HStack {
                        Text("Email")
                        Spacer()
                        Text(accountInfo.email)
                    }
                }
                
                NavigationLink(destination: ChangePassword().environmentObject(profileViewModel)) {
                    Text("Password")
                }
                
                NavigationLink(destination: ChangePhoneNumber().environmentObject(profileViewModel)) {
                    HStack {
                        Text("Phone number")
                        Spacer()
                        Text(accountInfo.phone)
                    }
                }
                
                Button {
                    deleteAccountAlert = true
                } label: {
                    Text("Remove account")
                        .foregroundColor(.red)
                }
                .alert("Are you sure you want to delete your account?", isPresented: $deleteAccountAlert) {
                    Button("Delete account", role: .destructive) {
                        profileViewModel.deleteAccount()
                    }
                }
                .onReceive(profileViewModel.$deleteAccountResonse) { apiResponse in
                    guard apiResponse.0 != nil else {
                        
                        guard let error = apiResponse.1 else {
                            return
                        }
                        
                        errorAlert = true
                        errorMessage = error.getErrorMessage()
                        return
                    }
                    
                    deleteSuccessfulAlert = true
                }
                .alert(errorMessage, isPresented: $errorAlert) {
                    Button("Ok", role: .cancel) {
                        
                    }
                }
                
                .alert("Delete was succesfully done.You will be loged out", isPresented: $deleteSuccessfulAlert) {
                    Button("Ok", role: .cancel) {
                        UserRepository.shared.logout()
                    }
                }
            }
        }
        .onAppear {
            profileViewModel.accountInfo()
        }
    }
}

struct AccountInfo_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfo()
    }
}
