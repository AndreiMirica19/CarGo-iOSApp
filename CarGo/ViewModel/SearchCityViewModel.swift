//
//  SearchCityViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 04.04.2023.
//

import Foundation
import MapKit
import Combine

class SearchCityViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    
    @Published var cityText = "" {
        didSet {
            searchForCity(text: cityText)
        }
    }
    
    @Published var viewData = [LocalSearchViewData]()
    
    var service = LocationSearchService()
    
    init() {
        cancellable = service.localSearchPublisher.sink { mapItems in
            self.viewData = mapItems.map({ LocalSearchViewData(mapItem: $0) })
        }
    }
    
    private func searchForCity(text: String) {
        service.requestCity(searchText: text)
    }
}
