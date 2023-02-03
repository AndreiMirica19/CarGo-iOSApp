//
//  EditProfile.swift
//  CarGo
//
//  Created by Andrei Mirica on 02.02.2023.
//

import SwiftUI

struct SpokenLanguages {
    var name: String
    var servingGoals: Set<Language>
}

struct EditProfile: View {
    
    var aboutPlaceholder = "Write anything you might think that is useful to know about you."
    @State var aboutText = ""
    @FocusState private var aboutFocus: Bool
    @State var country = ""
    @State var city = ""
    @State var job = ""
    @State var task = SpokenLanguages(name: "", servingGoals: [])
    var languages = Languages()
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: -28) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 128, height: 128)
                        .foregroundColor(.gray)
                    
                    Image(systemName: "pencil.circle")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .padding(.leading, 116)
                        .foregroundColor(.blue)
                }
                
                VStack(alignment: .leading) {
                    Text("About you")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    
                    TextEditor(text: $aboutText)
                        .foregroundColor(aboutText == aboutPlaceholder ? .gray : .black)
                        .frame(height: 216)
                        .padding()
                        .border(.black)
                        .onTapGesture {
                            if aboutText == aboutPlaceholder {
                                aboutText = ""
                            }
                        }
                        .focused($aboutFocus)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                if aboutFocus == true {
                                    VStack(alignment: .trailing) {
                                        Button("Done") {
                                            aboutFocus = false
                                            if aboutText.isEmpty {
                                                aboutText = aboutPlaceholder
                                            }
                                        }.frame(maxWidth: .infinity, alignment: .trailing)
                                        
                                    }
                                }
                            }
                        }
                    
                    Text("Where you live?")
                        .font(.headline)
                        .padding(.top)
                    
                    TextField(text: $country) {
                        Text("Country")
                    }
                    .padding()
                    .frame(height: 44)
                    .border(.black)
                    
                    TextField(text: $city) {
                        Text("City")
                    }
                    .padding()
                    .frame(height: 44)
                    .border(.black)
                    .padding(.top, 24)
                    
                    Text("What do you do for a living?")
                        .font(.headline)
                        .padding(.top)
                    
                    TextField(text: $job) {
                        Text("Current job")
                    }
                    .padding()
                    .frame(height: 44)
                    .border(.black)
                    
                    Text("What languages do you speak?")
                        .font(.headline)
                        .padding(.top)

                    MultiSelector(
                        label: Text("Spoken languages"),
                        options: languages.languagesList,
                        optionToString: { $0.name },
                        selected: $task.servingGoals
                    )
                    .padding()
                    .border(.black)
                    .padding(.top)
                }
            }.padding()
        }
        .padding(.top, 4)
        .onAppear {
            aboutText = aboutPlaceholder
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}
