//
//  LoginView.swift
//  CarGo
//
//  Created by Andrei Mirica on 18.12.2022.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var email = ""
    @State var password = ""
    @State var errorMessage = ""
    @State var displayError = false
    @ObservedObject var loginViewModel = LoginViewModel()
    @State var keepMeLogin = false
    @Binding var loginSuccessful: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundOrange")
                    .ignoresSafeArea()
                VStack(spacing: 32) {
                    Image("porsche")
                        .resizable()
                        .scaledToFill()
                    
                    Text("Welcome to CarGo!")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    VStack {
                        CustomTextView(text: $email, imageName: "mail", placeHolder: "Email")
                            .padding(.horizontal)
                            .frame(maxWidth: 400)
                        
                        PasswordTextView(text: $password, placeHolder: "Password")
                            .padding(.horizontal)
                            .frame(maxWidth: 400)
                        
                        HStack {
                            Image(systemName: keepMeLogin ? "checkmark.square.fill" : "square")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .onTapGesture {
                                    keepMeLogin.toggle()
                                }
                            
                            Text("Keep me login")
                                .fontWeight(.bold)
                        }.padding(.top)
                    }
                    
                    Button {
                        if !email.isEmpty && !password.isEmpty {
                            loginViewModel.login(loginData: LoginData(password: password, email: email), keepLogedIn: keepMeLogin)
                        } else {
                            errorMessage = "You must complete the fields."
                            displayError = true
                        }
                    } label: {
                        HStack {
                            Image(systemName: "person.badge.plus")
                                .foregroundColor(.white)
                            Text("Login")
                                .foregroundColor(.white)
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        .frame(minWidth: 300, minHeight: 44)
                    }
                    .alert("Error", isPresented: $displayError, actions: {}, message: {
                        Text(errorMessage)
                    })
                    .onReceive(loginViewModel.$response, perform: { response in
                        guard let userData = response.0 else {
                            guard let error = response.1 else {
                                return
                            }
                            errorMessage = error.getErrorMessage()
                            displayError = true
                            return
                        }
                        
                        loginSuccessful = true
                    })
                    .background(.black)
                    .cornerRadius(8)
                    
                    HStack {
                        Text("Don't you have an account?")
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundColor(.black)
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign up")
                                .fontWeight(.bold)
                                .font(.title3)
                        }
                    }
                    
                    Spacer(minLength: 36)
                }
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginSuccessful: .constant(false))
    }
}
