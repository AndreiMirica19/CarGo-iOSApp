//
//  BookingBanner.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.04.2023.
//

import SwiftUI

struct BookingBanner: View {
    
    @State var fromDate: Date?
    @State var toDate: Date?
    @State var price = ""
    var bookCar: ((_ fromDate: Date, _ toDate: Date) -> Void)
    
    var body: some View {
        VStack {
            if let fromDate = fromDate, let toDate = toDate {
                VStack {
                    HStack {
                        Text(fromDate.changeToLocalTimezone())
                            .fontWeight(.bold)
                        Image(systemName: "arrow.right")
                        Text(toDate.changeToLocalTimezone())
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        let numberOfDaysComponent = Calendar.current.dateComponents([.day], from: fromDate, to: toDate)
                        if let numberOfDays = numberOfDaysComponent.day {
                            Text("$\((Int(price) ?? 0) * numberOfDays) per \(numberOfDays) days")
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                        
                        Button {
                            bookCar(fromDate, toDate)
                        } label: {
                            Text("Book Car")
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 18).fill())
                        }
                    }
                }.padding()
            } else {
                NoDateSelectedBanner { fromDate, toDate in
                    self.fromDate = fromDate
                    self.toDate = toDate
                }
            }
        }
    }
}

struct BookingBanner_Previews: PreviewProvider {
    static var previews: some View {
        BookingBanner {fromDate,toDate in
            
        }
    }
}
