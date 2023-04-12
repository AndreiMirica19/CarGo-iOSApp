//
//  NoDateSelectedBanner.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.04.2023.
//

import SwiftUI

struct NoDateSelectedBanner: View {
    @State var isCalendarPickerPresented = false
    var dateSelected: ((_ fromDate: Date, _ toDate: Date) -> Void)
    
    var body: some View {
        HStack {
          
            Text("From 45$ per day")
                .fontWeight(.bold)
            Spacer()
            
            Button {
                isCalendarPickerPresented = true
            } label: {
                Text("Check availability")
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 18).fill())
            }
            
            .sheet(isPresented: $isCalendarPickerPresented) {
                MultiDatePickerView { startDate, endDate in
                    dateSelected(startDate, endDate)
                }
            }
        }
        .padding()
    }
}

struct NoDateSelectedBanner_Previews: PreviewProvider {
    static var previews: some View {
        NoDateSelectedBanner {_ ,_ in
            
        }
    }
}
