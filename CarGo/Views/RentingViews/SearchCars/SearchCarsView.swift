//
//  SearchCarsView.swift
//  CarGo
//
//  Created by Andrei Mirica on 25.01.2023.
//

import SwiftUI

struct SearchCarsView: View {
    @State var address = ""
    @State var rentPeriod = ""
    @StateObject var searchCarsViewModel = SearchCarsViewModel()
    @State var carList: [CarInfoDTO] = []
    @State var errorMessage = ""
    @State var isErrorShown = false
    @State var isFilterShown = false
    @State var filterData: FilterData?
    @State var fromDate: Date?
    @State var toDate: Date?
    @State var isDateSelectionShown = false
    @State var isCitySelectioShown = false
    
    var body: some View {
        
        NavigationStack {
            List {
                Section {
                    SymbolTextField(text: address, placeholder: "City", image: "map")
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            isCitySelectioShown = true
                        }
                    
                    SymbolTextField(text: searchCarsViewModel.dateRangeToString(fromDate: fromDate, toDate: toDate), placeholder: "Pick Up and Drop Off Dates", image: "calendar")
                        .onTapGesture {
                            isDateSelectionShown = true
                        }
                        .listRowSeparator(.hidden)
                }
                
                ForEach(carList, id: \.id) { car in
                    
                    ZStack {
                        NavigationLink {
                            CarDetailsView(carData: car)
                        } label: {
                            EmptyView().opacity(0.0)
                            
                        }
                        
                        CarInfoCardView(carInfo: car)
                        
                    }.padding()
                    
                }
            }.listStyle(.plain)
                .onAppear {
                    searchCarsViewModel.getAllCars()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Filter") {
                            isFilterShown = true
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Reset") {
                            reset()
                        }
                    }
                }
                .sheet(isPresented: $isFilterShown, content: {
                    FilterView { filter in
                        carList = searchCarsViewModel.filterCars(filterData: filter)
                        filterData = filter
                    }
                })
                .sheet(isPresented: $isDateSelectionShown, content: {
                    MultiDatePickerView(fromDate: fromDate, toDate: toDate) { fromDate, endDate in
                        self.fromDate = fromDate
                        self.toDate = endDate
                    }
                })
                .sheet(isPresented: $isCitySelectioShown, content: {
                    SearchCityView { address in
                        self.address = address
                        carList = searchCarsViewModel.filterByAddress(address: address)
                    }
                })
                .navigationTitle("CarGo")
                .navigationBarTitleDisplayMode(.inline)
                .onReceive(searchCarsViewModel.$allCarsResponse) { response in
                    guard let carList = response.0 else {
                        guard let error = response.1 else {
                            return
                        }
                        
                        self.errorMessage = error.getErrorMessage()
                        self.isErrorShown = true
                        return
                    }
                    
                    if let filterData = filterData {
                        self.carList = searchCarsViewModel.filterCars(filterData: filterData)
                    }
                    
                    self.carList = carList
                }
        }
    }
    
    func reset() {
        address = ""
        fromDate = nil
        toDate = nil
        
        carList = searchCarsViewModel.resetFilters()
    }
}

struct SearchCarsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCarsView()
    }
}
