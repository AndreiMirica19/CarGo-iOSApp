//
//  AddCarDescription.swift
//  CarGo
//
//  Created by Andrei Mirica on 08.03.2023.
//

import SwiftUI

struct AddCarDescription: View {
    @State var descriptionText = ""
    private var descriptionPlaceholder = "Write anything you consider that the users should know about your car"
    @EnvironmentObject var router: Router<AddCarPaths>
    @EnvironmentObject var carData: CarData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Car description")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            Text("Please add a description for the car.")
                .font(.subheadline)
            
            TextEditor(text: $descriptionText)
                .foregroundColor(descriptionText == descriptionPlaceholder ? .gray : .black)
                .frame(height: 216)
                .padding()
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                })
                .padding(.top, 32)
            
            Spacer()
            
            Button {
                carData.description = descriptionText
                router.push(.addCarLocation)
            } label: {
                Text("Next")
            }
            .padding()
            .padding(.top, 32)
            .cornerRadius(8)
            .buttonStyle(OutlineBorder(color: !descriptionText.isEmpty ? .blue : .gray))
            .disabled(descriptionText.isEmpty)
        }.padding()
    }
    
    init() {
        descriptionText = descriptionPlaceholder
    }
}

struct AddCarDescription_Previews: PreviewProvider {
    static var previews: some View {
        AddCarDescription()
    }
}
