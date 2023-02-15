//
//  ChangePassword.swift
//  CarGo
//
//  Created by Andrei Mirica on 15.02.2023.
//

import SwiftUI

struct ChangePassword: View {
    @State var oldPassword = ""
    @State var newPassword = ""
    @State var confirmPassword = ""
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State var alertIsPresent = false
    @State var alertMessage = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("You will use this password next time you login.")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                PasswordTextView(text: $oldPassword, placeHolder: "Old password")
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: 400)
                    .padding(.top, 32)
                
                PasswordTextView(text: $newPassword, placeHolder: "New password")
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: 400)
                    .padding(.top, 32)
                
                PasswordTextView(text: $confirmPassword, placeHolder: "Re-enter password ")
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: 400)
                    .padding(.top, 32)
                Spacer()
                
                HStack {
                    Spacer()
                    Button {
                        guard let accountInfo = profileViewModel.accountResponse.0 else {
                            return
                        }
                        
                        if accountInfo.password != oldPassword {
                            alertIsPresent = true
                            alertMessage = "Old password is not right one"
                            return
                        }
                        
                        if newPassword != confirmPassword {
                            alertIsPresent = true
                            alertMessage = "Password don't match"
                            return
                        }
                        
                        if newPassword.count < 10 {
                            alertIsPresent = true
                            alertMessage = "Password less than 10 characters"
                            return
                        }
                        
                        profileViewModel.changePassword(password: newPassword)
                        
                    } label: {
                        Text("Change password")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(minWidth: 300, minHeight: 44)
                        
                    }
                    .onReceive(profileViewModel.$changePasswordResponse) { apiResponse in
                        guard let response = apiResponse.0 else {
                            guard let error = apiResponse.1 else {
                                return
                            }
                            
                            alertIsPresent = true
                            alertMessage = error.getErrorMessage()
                            return
                        }
                        
                        alertIsPresent = true
                        alertMessage = response.message

                    }
                    .alert(alertMessage, isPresented: $alertIsPresent) {
                        Button("OK", role: .cancel) {
                            profileViewModel.accountInfo()
                        }
                    }
                    .background(.black)
                    .cornerRadius(16)
                    Spacer()
                }.padding(.top, 32)
            }.padding()
            .navigationTitle(Text("Change password"))
            .navigationBarTitleDisplayMode(.automatic)
            .onDisappear {
                alertMessage = ""
                alertIsPresent = false
            }
        }
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePassword()
    }
}
