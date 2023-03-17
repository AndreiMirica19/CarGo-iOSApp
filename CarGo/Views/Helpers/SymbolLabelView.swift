//
//  SymbolLabelView.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.03.2023.
//

import SwiftUI

struct SymbolLabelView: View {
    
    let symbolName: String
    let text: String
    let symbolColor: Color
    let textColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: symbolName)
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(symbolColor)
            Text(text)
                .foregroundColor(textColor)
        }
    }
}

struct SymbolLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolLabelView(symbolName: "star.fill", text: "4", symbolColor: .yellow, textColor: .black)
    }
}
