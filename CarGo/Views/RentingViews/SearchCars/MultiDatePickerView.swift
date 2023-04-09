//
//  SelectDatesView.swift
//  CarGo
//
//  Created by Andrei Mirica on 29.03.2023.
//

import SwiftUI

struct MultiDatePickerView: View {
    @Environment(\.presentationMode) var presentationMode
    var fromDate: Date?
    var toDate: Date?
    @State var fromHour = 0.0
    @State var toHour = 23.75
    
    var dateRange: ((_ startDate: Date, _ endDate: Date) -> Void)
    
    var body: some View {
        VStack {
            CalendarMultiDatePicker(toDate: toDate, fromDate: fromDate) { fromDate, toDate in
                
                let fromDateWithTime = Calendar.changeDateTime(hour: fromHour, date: fromDate)
                let toDateWithTime = Calendar.changeDateTime(hour: toHour, date: toDate)
                
                guard let fromDateWithTime = fromDateWithTime, let toDateWithTime = toDateWithTime else {
                    dateRange(fromDate, toDate)
                    return
                }
                
                dateRange(fromDateWithTime, toDateWithTime)
            }
            
            Section {
                HStack {
                    Text("00:00")
                    Slider(value: $fromHour, in: 0...23.75, step: 0.25)
                    Text("\(Int(fromHour)):\(String(format: "%02d", Int((fromHour.truncatingRemainder(dividingBy: 1)) * 60)))")
                }
            } header: {
                HStack {
                    Text("Pickup Hour")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("\(Int(fromHour)):\(String(format: "%02d", Int((fromHour.truncatingRemainder(dividingBy: 1)) * 60)))")
                        .font(.headline)
                }
            }.padding(.horizontal)
            
            Section {
                HStack {
                    Text("00:00")
                    Slider(value: $toHour, in: 0...23.75, step: 0.25)
                    Text("\(Int(toHour)):\(String(format: "%02d", Int((toHour.truncatingRemainder(dividingBy: 1)) * 60)))")
                }
            } header: {
                HStack {
                    Text("Dropoff Hour")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("\(Int(toHour)):\(String(format: "%02d", Int((toHour.truncatingRemainder(dividingBy: 1)) * 60)))")
                }
            }.padding(.horizontal)
                .padding(.bottom)
            
        }
    }
}

struct SelectDatesView_Previews: PreviewProvider {
    static var previews: some View {
        MultiDatePickerView(fromDate: nil, toDate: nil) {_, _ in
            
        }
    }
}
