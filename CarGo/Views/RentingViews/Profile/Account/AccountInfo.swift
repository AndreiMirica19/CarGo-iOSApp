//
//  AccountInfo.swift
//  CarGo
//
//  Created by Andrei Mirica on 13.02.2023.
//

import SwiftUI

struct AccountInfo: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
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
                
                NavigationLink(destination: EmptyView()) {
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
                    
                } label: {
                    Text("Remove account")
                        .foregroundColor(.red)
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
