//
//  HostView.swift
//  CarGo
//
//  Created by Andrei Mirica on 16.03.2023.
//

import SwiftUI

struct CarHostView: View {
    
    @State var isViewProfileActive = false
    @StateObject var hostInfoViewModel = HostViewModel()
    var ownerId: String
    @State var hostInfo: HostInfoDTO?
    @State var errorMessage = ""
    @State var errorIsShown = false
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    HStack {
            
                        if let hostInfo = hostInfo {
                            if let profilePictureImage = UIImage(data: hostInfo.hostDetails.profileImage) {
                                Image(uiImage: profilePictureImage)
                                    .resizable()
                                    .frame(width: 88, height: 88)
                                    .clipShape(Circle())
                            }
                        } else {
                            Image("porsche")
                                .resizable()
                                .frame(width: 88, height: 88)
                                .clipShape(Circle())
                        }
                        
                        VStack(alignment: .leading) {
                            Text(hostInfo?.hostDetails.name ?? "Full Name")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            StarsView()
                            
                            Button {
                                isViewProfileActive = true
                            } label: {
                                Text("View profile")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }.sheet(isPresented: $isViewProfileActive) {
                    if let hostInfo = hostInfo {
                        HostProfileView(hostInfo: hostInfo)
                    } else {
                        EmptyView()
                    }
                }
            } header: {
                Text("The Host")
                    .font(.headline)
            }
            
            Section {
                ForEach(0...15, id: \.self) { _ in
                    ReviewView()
                }
            } header: {
                Text("Reviews")
                    .font(.headline)
            }
        }
        .listStyle(.insetGrouped)
        .onAppear {
            hostInfoViewModel.hostInfo(id: ownerId)
        }
        .onReceive(hostInfoViewModel.$hostInfoResponse) { response in
            guard let hostInfoData = response.0 else {
                guard let error = response.1 else {
                    return
                }
                
                self.errorMessage = error.getErrorMessage()
                self.errorIsShown = true
                
                return
            }
            
            self.hostInfo = hostInfoData
        }
        .alert(errorMessage, isPresented: $errorIsShown) {
            Button("OK", role: .cancel) {
            }
        }
    }
}

struct HostView_Previews: PreviewProvider {
    static var previews: some View {
        CarHostView(ownerId: "")
    }
}
