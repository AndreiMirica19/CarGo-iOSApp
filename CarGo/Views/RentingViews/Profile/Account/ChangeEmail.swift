//
//  ChangeEmail.swift
//  CarGo
//
//  Created by Andrei Mirica on 14.02.2023.
//

import SwiftUI

struct ChangeEmail: View {
    @State var email = ""
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State var alertIsPresent = false
    @State var alertMessage = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("We will send a verification link to the new email.The new email will be used for login too.")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            CustomTextView(text: $email, imageName: "mail", placeHolder: "Email")
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                }
                .padding(.horizontal)
                .frame(maxWidth: 400)
                .padding(.top, 32)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    if email.isValidEmail() {
                        profileViewModel.changeEmail(email: email)
                    } else {
                        alertIsPresent = true
                        alertMessage = "Invalid email format."
                    }
                } label: {
                    Text("Change email")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(minWidth: 300, minHeight: 44)
                    
                }
                .background(.black)
                .cornerRadius(16)
                .onReceive(profileViewModel.$changeEmailResponse) { apiResponse in
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
                
                Spacer()
            }
        }
        .alert(alertMessage, isPresented: $alertIsPresent) {
            Button("OK", role: .cancel) {
                
            }
        }
        .padding()
        .navigationTitle(Text("Change Email"))
        .navigationBarTitleDisplayMode(.automatic)
        .onDisappear {
            alertMessage = ""
            alertIsPresent = false
        }

    }
}

struct ChangeEmail_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmail()
    }
}
