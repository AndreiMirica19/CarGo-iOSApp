//
//  CarTypesGridView.swift
//  CarGo
//
//  Created by Andrei Mirica on 23.03.2023.
//

import SwiftUI

struct CarTypesGridView: View {
    
    let columns = [
        GridItem(.flexible(), spacing: nil),
        GridItem(.flexible(), spacing: nil),
        GridItem(.flexible(), spacing: nil)
    ]
    
    @EnvironmentObject var filterViewModel: FilterViewMode
    
    var body: some View {
            LazyVGrid(columns: columns) {
                ForEach(CarType.allCases.dropFirst(), id: \.self) { carType in
                    CarTypeCell(car: carType.rawValue, isSelected: filterViewModel.selectedCarTypes.contains(carType.rawValue)) {
                        
                        if let index = filterViewModel.selectedCarTypes.firstIndex(of: carType.rawValue) {
                            filterViewModel.selectedCarTypes.remove(at: index)
                        } else {
                            filterViewModel.selectedCarTypes.append(carType.rawValue)
                        }
                    }
                    
                }
            }
    }
}

struct CarTypesGridView_Previews: PreviewProvider {
    static var previews: some View {
        CarTypesGridView()
    }
}
