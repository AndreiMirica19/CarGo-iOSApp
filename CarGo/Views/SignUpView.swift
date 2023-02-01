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
    @State var succesfulRegistration = false
    @State var errorRegistration = false
    @State var displayedErrorMessage = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @StateObject private var registerViewModel = RegisterViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Color("BackgroundOrange")
                        .ignoresSafeArea()
                    VStack {
                        Spacer(minLength: 80)
                        
                        CustomTextView(text: $name, imageName: "person", placeHolder: "Full name")
                        
                        CustomTextView(text: $email, imageName: "mail", placeHolder: "Email")
                        
                        CustomTextView(text: $phoneNumber, imageName: "phone", placeHolder: "Phone number").keyboardType(.numberPad)
                        
                        PasswordTextView(text: $password, placeHolder: "Password")
                        
                        PasswordTextView(text: $confirmPassword, placeHolder: "Confirm Password")
                        
                        Button {
                            if validateFields() {
                                registerViewModel.register(registerData: RegisterData(name: name, email: email, phoneNumber: phoneNumber, password: password))
                            }
        
                        } label: {
                            HStack {
                                Image(systemName: "person.badge.plus")
                                    .foregroundColor(.white)
                                Text("Sign Up")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            .frame(minWidth: 300, minHeight: 44)
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
                        
                        Spacer(minLength: 64)
            
                        HStack {
                            Text("Already have an account?")
                                .fontWeight(.bold)
                            Button {
                                self.mode.wrappedValue.dismiss()
                            } label: {
                                Text("Log in")
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.bold)
                            }
                        }
                        
                    }
                    .alert("Password do not match", isPresented: $notMatchingPasswordAlertIsShown) {
                        Button("OK", role: .cancel) { }
                    }
                    .onReceive(registerViewModel.$response, perform: { response in
                        guard let response = registerViewModel.response.0 else {
                            guard let error = registerViewModel.response.1 else {
                                return
                            }
                            errorRegistration = true
        
                            displayedErrorMessage = error.getErrorMessage()
                            return
                        }
                        
                        switch response.statusCode {
                        case 201:
                            succesfulRegistration = true
                            errorRegistration = false

                        default:
                            errorRegistration = true
                            succesfulRegistration = false
                            displayedErrorMessage = response.message
                            
                        }
                    })
                    .alert("Registration Complete", isPresented: $succesfulRegistration) {
                        Button("Login", role: .cancel) { }
                    }
                    .alert(displayedErrorMessage, isPresented: $errorRegistration) {
                        Button("OK", role: .cancel) { }
                    }
                }
            }
            .background {
                Color("BackgroundOrange")
                    .ignoresSafeArea()
            }
    
        }.navigationBarBackButtonHidden()
    }
    
    func validateFields() -> Bool {
        guard !name.isEmpty, !email.isEmpty, !phoneNumber.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            emptyFieldsAlertIsShown = true
            return false
        }
        
        guard email.isValidEmail() else {
            wrongEmailFormatAlertIsShown = true
            return false
        }
        
        guard phoneNumber.count == 10 else {
            wrongPhoneFormatAlertIsShown = true
            return false
        }
        
        guard password.count > 8 else {
            wrongPasswordFormatAlertIsShown = true
            return false
        }
        
        if password != confirmPassword {
            notMatchingPasswordAlertIsShown = true
            return false
        }
        return true
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
