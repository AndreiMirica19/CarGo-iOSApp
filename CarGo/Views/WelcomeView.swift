//
//  LoginView.swift
//  CarGo
//
//  Created by Andrei Mirica on 18.12.2022.
//

import SwiftUI
import AuthenticationServices

struct WelcomeView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationView {
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

                    Spacer()

                    SignInWithAppleButton { request in
                    } onCompletion: { result in
                    }
                    .frame(maxWidth: 300, maxHeight: 50)
                    .cornerRadius(8)

                    Button {
                    } label: {
                        HStack {
                            Image("google_logo")
                            Text("Sign in with Google")
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: 300, maxHeight: 50)

                    }
                    .background(.black)
                    .cornerRadius(8)

                    Button {
                    } label: {
                        HStack {
                            Image(systemName: "mail")
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                            Text("Sign in with Email")
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: 300, maxHeight: 50)
                    }
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
        WelcomeView()
    }
}
