//
//  TermsAndConditions.swift
//  CarGo
//
//  Created by Andrei Mirica on 01.02.2023.
//

import SwiftUI

struct TermsAndConditions: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text("Terms and Conditions for Peer-to-Peer Car Sharing App")
                        .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    
                    Text("Introduction:")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("Welcome to the Peer-to-Peer Car Sharing App (the \"App\"). The following terms and conditions (the \"Terms\") govern your use of the App and the services offered through the App (the\"Owners\") in accordance with the terms set forth in these Terms. By using the Services, you agree to be bound by these Terms. If you do not agree to these Terms, you should not use the Services.")

                    
                    Text("Ownership and Use of Vehicles:")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("The Owners retain all rights, title, and interest in the vehicles listed for rental through the Services. You are renting the vehicles only for the term and in accordance with the terms specified in the App. You agree not to sell, rent, lease, sublease, pledge, or otherwise transfer any interest in the vehicles or to use the vehicles for any commercial purpose, including but not limited to transportation of goods or passengers for hire.")
                    
                    Text("Responsibilities of Owners:")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("Owners are solely responsible for the condition, maintenance, and repair of their vehicles, as well as the compliance of their vehicles with all applicable laws and regulations. Owners are also responsible for ensuring that the vehicles are available for rent at the times and for the terms specified in the App, and for promptly communicating with renters in the event of any changes to availability")
                    
                    Text("Responsibilities of Renters:")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("Renters are responsible for the safe and proper operation of the vehicles rented through the Services, and for returning the vehicles in the same condition as when received, reasonable wear and tear excepted. Renters must comply with all applicable laws and regulations while using the vehicles, and must not engage in any illegal or dangerous activities while using the vehicles. Renters are also responsible for any damage to or loss of the vehicles, up to the amount specified in the App.")
                }
                
  
                Group {
                    Text("Fees and Payments:")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("Renters are responsible for paying the fees for the Services, as specified in the App. The fees include the rental fee for the vehicle, as well as any applicable taxes, fees, or charges. Renters may be required to provide a security deposit, as specified in the App. Owners may receive a portion of the fees for the Services, as specified in the App.")
                    
                    Text("Disclaimers:")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("The App and the Services are provided \"as is\" without warranty of any kind, either express or implied. The App and the Services may contain errors, bugs, or other limitations. The App and the Services are not designed to meet your specific requirements, and we do not guarantee that the App or the Services will be suitable for your needs..")
                    
                    Text("Limitation of Liability:")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("In no event shall the App or its affiliates be liable for any damages, including without limitation direct or indirect, special, incidental, or consequential damages, losses or expenses arising in connection with the App or the Services or your use thereof or inability to use by any party, or in connection with any failure of performance, error, omission, interruption, defect, delay in operation or transmission, computer virus or line or system failure, even if the App, or representatives thereof, are advised of the possibility of such damages, losses or expenses.")
                    
                    Text("Indemnification:")
                        .font(.headline)
                        .padding(.top)
                    
                    
                    Text("You agree to indemnify, defend and hold harmless the App and its affiliates, and their respective officers, directors, agents, and employees, from any and all claims, liabilities, damages, and expenses, including reasonable attorneys' fees.")
                }
            }
        }.padding()
    }
}

struct TermsAndConditions_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditions()
    }
}
