//
//  MyCarsView.swift
//  CarGo
//
//  Created by Andrei Mirica on 16.02.2023.
//

import SwiftUI

struct MyCarsView: View {
    @State private var displayAddCar = false
    @StateObject private var myCarsViewModel = MyCarsViewModel()
    @State private var carList: [CarInfoDTO] = []
    @State private var displayAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            List(carList, id: \.id) { car in
                if let carImageData = car.photos.first {
                    if let carImage = UIImage(data: carImageData) {
                        NavigationLink(destination: CarDetailsView(carData: car)) {
                            
                            OwnedCarView(carName: "\(car.manufacturer) \(car.model)", location: car.street, numberPlate: car.numberPlate, image: carImage)
                        }
 
                    }
                }
            }
            .toolbar {
                Button("Add Car") {
                    displayAddCar = true
                }
            }
            .navigationTitle(Text("My Cars"))
            .sheet(isPresented: $displayAddCar, onDismiss: {
                myCarsViewModel.ownedCars()
            }){
                AddCarContentView()
            }
            .onReceive(myCarsViewModel.$ownedCarsResponse) { response in
                guard let ownedCarList = response.0 else {
                    guard let error = response.1 else {
                        return
                    }
                    displayAlert = true
                    alertMessage = error.getErrorMessage()
                    return
                }
                carList = ownedCarList
            }
            .alert(alertMessage, isPresented: $displayAlert) {
                Button("OK", role: .cancel) {
                    
                }
            }
        }.onAppear {
            myCarsViewModel.ownedCars()
        }
    }
}

struct MyCarsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCarsView()
    }
}
