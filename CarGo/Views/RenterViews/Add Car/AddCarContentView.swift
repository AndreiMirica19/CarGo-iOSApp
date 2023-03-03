//
//  AddCarContentView.swift
//  CarGo
//
//  Created by Andrei Mirica on 28.02.2023.
//

import SwiftUI

struct AddCarContentView: View {
    
    @ObservedObject var router = Router<AddCarPaths>()
    
    var body: some View {
        NavigationStack(path: $router.paths) {
            AddCarNumberPlate()
                .navigationDestination(for: AddCarPaths.self) { path in
                    switch path {
                    case .addCarNumberPlate:
                        AddCarNumberPlate()
                        
                    case .addCarDetails:
                        AddCarDetails().environmentObject(router)
                        
                    case .addCarLocation:
                        AddCarLocation().environmentObject(router)
                        
                    case .addCarPhotos:
                        EmptyView()
                        
                    case .addCarPrice:
                        EmptyView()
                    }
                }
            .environmentObject(router)
            .navigationTitle("Add car")
            .navigationBarTitleDisplayMode(.inline)
        }
         
    }
}

struct AddCarContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddCarContentView()
    }
}
