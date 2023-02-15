//
//  ChangePhoneNumber.swift
//  CarGo
//
//  Created by Andrei Mirica on 14.02.2023.
//

import SwiftUI

struct ChangePhoneNumber: View {
    @State var phoneNumber = ""
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State var alertIsPresent = false
    @State var alertMessage = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("We will send a verification link SMS to the new phone number")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                CustomTextView(text: $phoneNumber, imageName: "phone", placeHolder: "Phone number")
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
                        if phoneNumber.isValidPhoneNumber() {
                            profileViewModel.changePhoneNumber(phoneNumber: phoneNumber)
                        } else {
                            alertMessage = "Invalid phone number format"
                            alertIsPresent = true
                        }
                    } label: {
                        Text("Change phone number")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(minWidth: 300, minHeight: 44)
                        
                    }
                    .background(.black)
                    .cornerRadius(16)
                    .onReceive(profileViewModel.$changePhoneNumberResponse) { apiResponse in
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
            .navigationTitle(Text("Change phone number"))
            .navigationBarTitleDisplayMode(.automatic)
            .onDisappear {
                alertMessage = ""
                alertIsPresent = false
            }

        }
    }
}

struct ChangePhoneNumber_Previews: PreviewProvider {
    static var previews: some View {
        ChangePhoneNumber()
    }
}
