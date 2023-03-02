//
//  PickerAndTitle.swift
//  CarGo
//
//  Created by Andrei Mirica on 01.03.2023.
//

import SwiftUI

struct PickerAndTitle: View {
    @Binding var selectedItem: String
    var items: [String]
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
             Text(title)
                 .font(.headline)
                 .fontWeight(.bold)
             
             Picker(title, selection: $selectedItem) {
                 ForEach(items, id: \.self) {
                     Text($0)
                 }
             }.tint(.black)
        }
    }
}

struct PickerAndTitle_Previews: PreviewProvider {
    static var previews: some View {
        PickerAndTitle(selectedItem: .constant(""), items: ["d", "f"], title: "Select letter")
    }
}
