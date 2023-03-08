//
//  AddCarContentView.swift
//  CarGo
//
//  Created by Andrei Mirica on 28.02.2023.
//

import SwiftUI

struct AddCarContentView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var router = Router<AddCarPaths>()
    @ObservedObject var carData = CarData()
    
    var body: some View {
        NavigationStack(path: $router.paths) {
            AddCarNumberPlate()
                .navigationDestination(for: AddCarPaths.self) { path in
                    switch path {
                    case .addCarNumberPlate:
                        AddCarNumberPlate()
                        
                    case .addCarDetails:
                        AddCarDetails().environmentObject(router)
                            .environmentObject(carData)
                    
                    case .addCarDescription:
                        AddCarDescription().environmentObject(router)
                            .environmentObject(carData)
                        
                    case .addCarLocation:
                        AddCarLocation().environmentObject(router)
                            .environmentObject(carData)
                        
                    case .addCarPhotos:
                        AddCarPhotos().environmentObject(router)
                            .environmentObject(carData)
                        
                    case .addCarPrice:
                        AddCarPrice(dismissSheet: {
                            dismiss()
                        }).environmentObject(router)
                            .environmentObject(carData)
                    }
                }
            .environmentObject(router)
            .environmentObject(carData)
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
