//
//  AddCarLicence.swift
//  CarGo
//
//  Created by Andrei Mirica on 28.02.2023.
//

import SwiftUI

struct AddCarNumberPlate: View {
    @EnvironmentObject var router: Router<AddCarPaths>
    @EnvironmentObject var carData: CarData
    @State var numberPlate = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Section {
                
                Text("Please enter the number plate of your car. After we verify it, you can go to the next step.")
                    .padding(.horizontal, 24)
                    .padding(.top, 4)
                    .font(.headline)
                
                CarNumberPlateView(numberPlate: $numberPlate)
                    .padding(.horizontal, 48)
                
            } header: {
                Text("Number Plate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading, 24)
                    .padding(.top)
            }
            
            Spacer()
            
            Button {
                carData.numberPlate = numberPlate
                router.push(.addCarDetails)
            } label: {
                Text("Next")
            }
            .padding()
            .cornerRadius(8)
            .buttonStyle(OutlineBorder(color: numberPlate.isValidNumberPlate() ? .blue : .gray))
            .disabled(!numberPlate.isValidNumberPlate())
        }
    }
}

struct AddCarLicence_Previews: PreviewProvider {
    static var previews: some View {
        AddCarNumberPlate()
    }
}
