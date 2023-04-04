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
    
    var dateRange: ((_ startDate: Date, _ endDate: Date) -> Void)
    
    var body: some View {
            VStack {
                CalendarMultiDatePicker(toDate: toDate, fromDate: fromDate) { fromDate, toDate in
                    dateRange(fromDate, toDate)
                }
            }
        }
    }

struct SelectDatesView_Previews: PreviewProvider {
    static var previews: some View {
        MultiDatePickerView(fromDate: nil, toDate: nil) {_, _ in 
            
        }
    }
}
