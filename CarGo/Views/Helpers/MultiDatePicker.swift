//
//  MultiDatePicker.swift
//  CarGo
//
//  Created by Andrei Mirica on 30.03.2023.
//

import SwiftUI
import Fastis

struct CalendarMultiDatePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    var toDate: Date?
    var fromDate: Date?
    var dateRange: ((_ startDate: Date, _ endDate: Date) -> Void)

    func makeUIViewController(context: Context) -> UINavigationController {
        let fastisController = FastisController(mode: .range)
        fastisController.allowToChooseNilDate = true
        
        fastisController.initialValue = FastisRange(from: fromDate ?? Date(), to: toDate ?? Date())
        fastisController.doneHandler = { resultRange in
            guard let resultRange = resultRange else {
                return
            }
            
            dateRange(Date.changeToLocalTimezone(initialDate: resultRange.fromDate), Date.changeToLocalTimezone(initialDate: resultRange.toDate))
        }
        
        let navigationController = UINavigationController(rootViewController: fastisController)
        fastisController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: fastisController, action: #selector(FastisController<FastisRange>.dismiss))
        
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
}
