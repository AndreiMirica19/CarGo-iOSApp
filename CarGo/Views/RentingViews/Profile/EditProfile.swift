//
//  EditProfile.swift
//  CarGo
//
//  Created by Andrei Mirica on 02.02.2023.
//

import SwiftUI
import PhotosUI

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
    @State var presentActionSheet = false
    @State var presentGallery = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var profilePicture: UIImage?
    @State private var showCamera = false

    var languages = Languages()
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: -28) {
                    if let profilePicture = profilePicture {
                        Image(uiImage: profilePicture)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 128, height: 128)
                            .clipShape(Circle())
                        
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 128, height: 128)
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                    }
                    
                    Image(systemName: "pencil.circle")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .padding(.leading, 128)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            presentActionSheet = true
                        }
                        .confirmationDialog("", isPresented: $presentActionSheet) {
                            Button("Camera") {
                                showCamera = true
                            }
                            
                            Button("Gallery") {
                                presentGallery = true
                            }
                            
                            Button("Remove photo", role: .destructive) {
                                selectedImageData = nil
                                profilePicture = nil
                            }
                        }
                        .photosPicker(isPresented: $presentGallery, selection: $selectedItem, matching: .images)
                        .sheet(isPresented: $showCamera) {
                            ImagePicker(isShown: $showCamera, imageData: $selectedImageData, image: $profilePicture)
                        }
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                    guard let selectedImageData = selectedImageData else {
                                        return
                                    }
                                    profilePicture = UIImage(data: selectedImageData)
                                }
                            }
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("About you")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    
                    TextEditor(text: $aboutText)
                        .foregroundColor(aboutText == aboutPlaceholder ? .gray : .black)
                        .frame(height: 216)
                        .padding()
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        })
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
                    
                    CustomTextField(text: $country, placeholder: "Country")
                    
                    CustomTextField(text: $city, placeholder: "City")
                        .padding(.top)
                    
                    Text("What do you do for a living?")
                        .font(.headline)
                        .padding(.top)
                    
                    CustomTextField(text: $job, placeholder: "Current job")
                    
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
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    })
                    .padding(.top)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Save")
                        }
                        .padding()
                        .cornerRadius(8)
                        .buttonStyle(OutlineBorder(color: .blue))
                        Spacer()
                    }
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

struct OutlineBorder: ButtonStyle {

    var color: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
