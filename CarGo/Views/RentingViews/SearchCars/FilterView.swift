//
//  FilterView.swift
//  CarGo
//
//  Created by Andrei Mirica on 23.03.2023.
//

import Sliders
import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var filterViewModel = FilterViewMode()
    @State  var manufacturer = "-"
    @State  var carModel = "-"
    @State  var color = "-"
    @State  var fuel = "-"
    @State  var numberOfSeats = "5"
     var numberOfSeatsArray: [String] = Array(1...8).map { String($0) }
    @State var range = 0.0...1
    @State var radius = 0.0
    @State var yearRange = 0.0...1
    @State var transmissions: [String] = []
    var filter: ((_ filterData: FilterData) -> Void)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Section {
                        RangeSlider(range: $range, step: 0.025)
                    } header: {
                        HStack {
                            Text("Price Per Day")
                                .foregroundColor(.black)
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("\(Int(range.lowerBound * 200))$ - \(Int(range.upperBound * 200))$")
                            
                        }
                    }
                    
                    Section {
                        Slider(value: $radius, in: 0...60)
                    } header: {
                        HStack {
                            Text("Radius")
                                .foregroundColor(.black)
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("\(Int(radius)) km away")
                            
                        }
                    }
                    
                    Section {
                        CarTypesGridView().environmentObject(filterViewModel)
                    } header: {
                        Text("Car type")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                    
                    Section {
                        PickerAndTitle(selectedItem: $manufacturer, items: filterViewModel.getCarManufacturers(), title: "Select the car manufacturer")
                            .padding(.top)
                        Divider()
                        
                        PickerAndTitle(selectedItem: $manufacturer, items: filterViewModel.getCarModels(carManufacturer: manufacturer), title: "Select the car model")
                            .padding(.top)
                        
                        Divider()
                        
                        Section {
                            HStack {
                                Spacer()
                                
                                ForEach(CarTransmision.allCases.dropFirst(), id: \.self) { transmission in
                                    CarTransmissionView(image: transmission.rawValue, text: transmission.rawValue, isSelected: transmissions.contains(transmission.rawValue)) {
                                        if let index = transmissions.firstIndex(of: transmission.rawValue) {
                                            transmissions.remove(at: index)
                                        } else {
                                            transmissions.append(transmission.rawValue)
                                        }
                                    }.padding(.horizontal)
                                }
                                
                                Spacer()
                            }
                        } header: {
                            Text("Select the transmission")
                                .foregroundColor(.black)
                                .font(.headline)
                        }
                        
                        Divider()
                        
                        PickerAndTitle(selectedItem: $color, items: CarColor.allCases.map { $0.rawValue }, title: "Select the color")
                            .padding(.top)
                        
                        Divider()
                        
                        PickerAndTitle(selectedItem: $fuel, items: CarFuel.allCases.map { $0.rawValue }, title: "Select the fuel")
                            .padding(.top)
                        
                    }
                    
                    Section {
                        Divider()
                        
                        PickerAndTitle(selectedItem: $numberOfSeats, items: numberOfSeatsArray, title: "Select the number of seats")
                            .padding(.top)
                    }
                    
                    Section {
                        RangeSlider(range: $yearRange, step: 1 / 53)
                    } header: {
                        HStack {
                            Text("Year")
                                .foregroundColor(.black)
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("\(yearBoundToString(bound: yearRange.lowerBound)) -\(yearBoundToString(bound: yearRange.upperBound))")
                        }
                    }
                    
                    Section {
                        
                        Button {
                            filter( FilterData(manufacturer: manufacturer, carModel: carModel, transmission: transmissions, color: color, fuel: fuel, numberOfSeats: numberOfSeats, startPrice: Int(range.lowerBound * 200), endPrice: Int(range.upperBound * 200), radius: radius, startYear: (Int(yearRange.lowerBound * 53) + 1970), endYear: (Int(yearRange.upperBound * 53) + 1970), carTypes: filterViewModel.selectedCarTypes))
                            dismiss()
                        } label: {
                            Text("Filter")
                        }
                        .padding()
                        .cornerRadius(8)
                        .buttonStyle(OutlineBorder(color: .blue))
                        
                    }
                }.padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset") {
                        reset()
                    }
                }
            }
            .onAppear {
                filterViewModel.fetchCars()
            }
        }
    }
    
    func yearBoundToString(bound: Double) -> String {
        let intYear = Int(bound * 53) + 1970
        return String(intYear)
    }
    
    func reset() {
        range = 0.0...1
        radius = 0.0
        filterViewModel.selectedCarTypes = []
        carModel = "-"
        manufacturer = "-"
        transmissions = []
        color = "-"
        numberOfSeats = "5"
        yearRange = 0.0...1
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView { _ in
            
        }
    }
}
