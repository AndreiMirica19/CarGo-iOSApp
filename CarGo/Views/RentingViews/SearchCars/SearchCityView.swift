//
//  SearchCityView.swift
//  CarGo
//
//  Created by Andrei Mirica on 04.04.2023.
//

import SwiftUI

struct SearchCityView: View {
    @StateObject private var viewModel = SearchCityViewModel()
    @Environment(\.dismiss) var dismiss
    var locationSelected: (( _ address: String) -> Void)
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(text: $viewModel.cityText, placeholder: "City name")
                    .padding()
                Divider()
                
                List(viewModel.viewData) { item in
                    VStack(alignment: .leading) {
                        Text(item.title)
                        Text(item.subtitle)
                            .foregroundColor(.secondary)
                    }.onTapGesture {
                        locationSelected(item.subtitle)
                        dismiss()
                    }
                }
            }.navigationTitle("Search City")
        }
    }
}

struct SearchCityView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCityView {_ in
            
        }
    }
}
