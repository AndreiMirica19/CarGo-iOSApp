//
//  AddCarPrice.swift
//  CarGo
//
//  Created by Andrei Mirica on 03.03.2023.
//

import SwiftUI

struct AddCarPrice: View {
    @State var price = ""
    @State var currency = 0
    @State var durationDiscount = false
    var body: some View {
        VStack(alignment: .leading) {
            CustomInputView(text: $price, label: "Price per day", onCommit: {})
                .padding(.top, 32)
            
            Picker("What currency?", selection: $currency) {
                Text("Ron").tag(0)
                Text("€").tag(1)
            }
            .pickerStyle(.segmented)
            
            Text("Please note that a portion of this price will be deducted for taxes and insurance.")
                .foregroundColor(.gray)
                .font(.footnote)
                
                Toggle(isOn: $durationDiscount, label: {
                    Text("Duration Discount")
                        .font(.subheadline)
                    .fontWeight(.medium)
                }).padding(.top, 16)
            
            Text("Offering a discount for long-term bookings can increase the attractiveness of renting your car for a prolonged period. Renters will receive a 10% discount for rental periods of 7 days or more, which will be deducted from the total rental cost.")
                .foregroundColor(.gray)
                .font(.footnote)
            
            Spacer()

            Button {
                // router.push(.addCarPrice)
            } label: {
                Text("Next")
            }
            .padding()
            .padding(.top, 32)
            .cornerRadius(8)
            .buttonStyle(OutlineBorder(color: !price.isEmpty ? .blue : .gray))
            .disabled(price.isEmpty)
            
        }.padding(.horizontal, 24)
    }
}

struct AddCarPrice_Previews: PreviewProvider {
    static var previews: some View {
        AddCarPrice()
    }
}
