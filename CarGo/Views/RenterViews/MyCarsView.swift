//
//  MyCarsView.swift
//  CarGo
//
//  Created by Andrei Mirica on 16.02.2023.
//

import SwiftUI

struct MyCarsView: View {
    @State private var displayAddCar = false
    var body: some View {
        NavigationStack {
            List {
                
            }
            .toolbar {
                Button("Add Car") {
                    displayAddCar = true
                }
            }
            .sheet(isPresented: $displayAddCar) {
                AddCarContentView()
            }
        }
    }
}

struct MyCarsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCarsView()
    }
}
