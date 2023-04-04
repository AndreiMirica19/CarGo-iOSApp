//
//  LocationSearchService.swift
//  CarGo
//
//  Created by Andrei Mirica on 04.04.2023.
//

import Foundation
import Combine
import MapKit

class LocationSearchService {
    let localSearchPublisher = PassthroughSubject<[MKMapItem], Never>()
    
    func requestCity(searchText: String) {
        
        guard searchText.count > 3 else {
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = .address
        let search = MKLocalSearch(request: request)
        search.start { [weak self](response, _) in
            
            guard let response = response else {
                return
            }
            
            self?.localSearchPublisher.send(response.mapItems)
        }
    }
}
