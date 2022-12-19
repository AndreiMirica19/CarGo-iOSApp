//
//  SignUpView.swift
//  CarGo
//
//  Created by Andrei Mirica on 19.12.2022.
//

import SwiftUI

struct SignUpView: View {
    @State var name = ""
    @State var email: String = ""
    @State var phoneNumber = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var emptyFieldsAlertIsShown = false
    @State var wrongEmailFormatAlertIsShown = false
    @State var wrongPhoneFormatAlertIsShown = false
    @State var wrongPasswordFormatAlertIsShown = false
    @State var notMatchingPasswordAlertIsShown = false

    var body: some View {
        ScrollView {
            NavigationView {
                ZStack {
                    Color("BackgroundOrange")
                        .ignoresSafeArea()
                    VStack {
                        CustomTextView(text: $name, imageName: "person", placeHolder: "Full name")

                        CustomTextView(text: $email, imageName: "mail", placeHolder: "Email")

                        CustomTextView(text: $phoneNumber, imageName: "phone", placeHolder: "Phone number").keyboardType(.numberPad)

                        PasswordTextView(text: $password, placeHolder: "Password")

                        PasswordTextView(text: $confirmPassword, placeHolder: "Confirm Password")

                        Button {
                            validateFields()
                        } label: {
                            HStack {
                                Image(systemName: "person.badge.plus")
                                    .foregroundColor(.white)
                                Text("Sign Up")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                .fontWeight(.semibold)
                            }
                            .frame(maxWidth: 300, maxHeight: 50)
                        }
                        .background(.black)
                        .cornerRadius(8)
                        .alert("Some fields are empty.", isPresented: $emptyFieldsAlertIsShown) {
                                Button("OK", role: .cancel) { }
                        }
                        .alert("Wrong email format", isPresented: $wrongEmailFormatAlertIsShown) {
                            Button("Ok", role: .cancel) {}
                        } message: {
                            Text("Email should have a format like: example@mail.com")
                        }
                        .alert("Wrong phone number format", isPresented: $wrongPhoneFormatAlertIsShown) {
                                Button("OK", role: .cancel) { }
                        }
                        .alert("Wrong password format", isPresented: $wrongPasswordFormatAlertIsShown) {
                            Button("Ok", role: .cancel) {}
                        } message: {
                            Text("Password should be at least 8 characters")
                        }
                    }
                    .alert("Password do not match", isPresented: $notMatchingPasswordAlertIsShown) {
                            Button("OK", role: .cancel) { }
                    }
                }
            }
            .navigationTitle("Sign up")
        .navigationBarTitleDisplayMode(.large)
        }.background {
            Color("BackgroundOrange")
                .ignoresSafeArea()
        }
    }

    func validateFields() {
        guard !name.isEmpty, !email.isEmpty, !phoneNumber.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            emptyFieldsAlertIsShown = true
            return
        }

        guard email.isValidEmail() else {
            wrongEmailFormatAlertIsShown = true
            return
        }

        guard phoneNumber.count == 10 else {
            wrongPhoneFormatAlertIsShown = true
            return
        }

        guard password.count > 8 else {
            wrongPasswordFormatAlertIsShown = true
            return
        }

        if password != confirmPassword {
            notMatchingPasswordAlertIsShown = true
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
