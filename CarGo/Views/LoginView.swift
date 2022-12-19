//
//  LoginView.swift
//  CarGo
//
//  Created by Andrei Mirica on 18.12.2022.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to CarGo!")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
