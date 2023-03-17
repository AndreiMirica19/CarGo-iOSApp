//
//  ViewProfile.swift
//  CarGo
//
//  Created by Andrei Mirica on 02.02.2023.
//

import SwiftUI

struct ProfileDetails: View {
    @State var editProfile = false
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var router: Router<ProfilePaths>
    
    var body: some View {
        VStack(alignment: .leading) {
            if let userInfo = profileViewModel.response.0, let accountInfo = profileViewModel.accountResponse.0 {
                Section {
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            userInfo.profileImage.imageFromData()
                                .resizable()
                                .frame(width: 128, height: 128)
                                .clipShape(Circle())
                            
                            Text("Hi, I'm \(accountInfo.name)!")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                    }
                }
                
                Divider()
                
                Section {
                    Text(userInfo.about)
                        .padding(.top, 4)
                    
                } header: {
                    Text("About")
                        .fontWeight(.bold)
                }.padding(.horizontal, 16)
                
                Divider()
                
                Section {
                    SymbolLabelView(symbolName: "house", text: "Lives in \(userInfo.city), \(userInfo.country)", symbolColor: .black, textColor: .black)
                    
                    SymbolLabelView(symbolName: "bubble.left.and.bubble.right", text: "Speaks \(userInfo.spokenLanguages.joined(separator: ", "))", symbolColor: .black, textColor: .black)
                    
                    SymbolLabelView(symbolName: "suitcase", text: userInfo.job, symbolColor: .black, textColor: .black)
                } header: {
                    Text("Details")
                        .fontWeight(.bold)
                }.padding(.horizontal, 16)
                
                Divider()
                
                Spacer()
                
            } else {
                IncompleteProfile()
            }
        }
        .toolbar {
            Button {
                router.push(.editProfile)
            } label: {
                Image(systemName: "pencil")
            }
            .frame(width: .infinity, alignment: .leading)
        }
        .onAppear {
            profileViewModel.userInfo()
            profileViewModel.accountInfo()
        }
    }
}

struct ViewProfile_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
