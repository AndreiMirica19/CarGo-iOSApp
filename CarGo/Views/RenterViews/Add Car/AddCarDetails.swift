//
//  AddCarDetails.swift
//  CarGo
//
//  Created by Andrei Mirica on 01.03.2023.
//

import SwiftUI

struct AddCarDetails: View {
    @EnvironmentObject var router: Router<AddCarPaths>
    @State private var manufacturer = "-"
    @State private var carModel = "-"
    @State private var year = "2023"
    @State private var transmission = "-"
    @State private var color = "-"
    @State private var fuel = "-"
    @State private var numberOfSeats = "1"
    @StateObject var addCarViewModel = AddCarViewModel()
    @State var manufacturers: [String] = []
    @State var models: [String] = []
    private var numberOfSeatsArray: [String] = Array(1...8).map { String($0) }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Section {
                    Text("Car Info")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                        .padding(.top)
                    
                    Text("Please complete the following fields.")
                        .padding(.top, 4)
                        .font(.headline)
                }
               
                Section {
                    PickerAndTitle(selectedItem: $manufacturer, items: addCarViewModel.getCarManufacturers(), title: "Select the car manufacturer")
                        .padding(.top)
                    
                    Divider()
                    
                    PickerAndTitle(selectedItem: $carModel, items: addCarViewModel.getCarModels(carManufacturer: manufacturer), title: "Select the car model")
                        .padding(.top)
                    
                    Divider()
                    
                    PickerAndTitle(selectedItem: $year, items: Calendar.getYears(), title: "Select the year of manufacture")
                        .padding(.top)
                    
                    Divider()
                }
                
                Section {
                    PickerAndTitle(selectedItem: $transmission, items: CarTransmision.allCases.map { $0.rawValue }, title: "Select the transmission")
                        .padding(.top)
                    
                    Divider()
                    
                    PickerAndTitle(selectedItem: $color, items: CarColor.allCases.map { $0.rawValue }, title: "Select the color")
                        .padding(.top)
                    
                    Divider()
                    
                    PickerAndTitle(selectedItem: $fuel, items: CarFuel.allCases.map { $0.rawValue }, title: "Select the fuel")
                        .padding(.top)
                    
                    Divider()
                    
                    PickerAndTitle(selectedItem: $numberOfSeats, items: numberOfSeatsArray, title: "Select the number of seats")
                        .padding(.top)
                    
                    Divider()
                    
                }
                
                Spacer()
                
                Button {
                    router.push(.addCarDetails)
                } label: {
                    Text("Next")
                }
                .padding()
                .cornerRadius(8)
                .buttonStyle(OutlineBorder(color: checkFormCompletion() ? .blue : .gray))
                .disabled(!checkFormCompletion())
               
            }.padding(.horizontal, 24)
        }.padding(.top)
            .onAppear {
                addCarViewModel.fetchCars()
            }
            .onReceive(addCarViewModel.$carListResponse) { response in
                guard let carList = response.0 else {
                    return
                }
                self.manufacturers = carList.map { $0.manufacturer }
            }
    }
    
    func checkFormCompletion() -> Bool {
        print(color)
        return manufacturer != "-" && carModel != "-" && transmission != "-" && color != "-" && fuel != "-"
    }
}

struct AddCarDetails_Previews: PreviewProvider {
    static var previews: some View {
        AddCarDetails()
    }
}
