//
//  PorfileView.swift
//  CarGo
//
//  Created by Andrei Mirica on 25.01.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var isLoggedIn = false
    @State var isRoot = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                   // UserDefaults.standard.removeObject(forKey: "userId")
                   changeRootView()
                } label: {
                    Text("Logout")
                }
            }
        }
    }
    
    func changeRootView() {
        let window = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        
        window?.rootViewController = UIHostingController(rootView: LoginView())
        window?.makeKeyAndVisible()
 
    }
}

struct PorfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
