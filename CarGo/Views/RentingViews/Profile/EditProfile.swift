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
    var languages: Set<Language>
}

struct EditProfile: View {
    @Binding var userInfo: UserDetailsData?
    var aboutPlaceholder = "Write anything you might think that is useful to know about you."
    let editProfileViewModel = EditProfileViewModel()
    @Environment(\.presentationMode) private var mode: Binding<PresentationMode>
    @State var aboutText = ""
    @FocusState var aboutFocus: Bool
    @State var country = ""
    @State var city = ""
    @State var job = ""
    @State var spokenLanguages = SpokenLanguages(name: "", languages: [])
    @State var presentActionSheet = false
    @State var presentGallery = false
    @State var selectedItem: PhotosPickerItem?
    @State var selectedImageData: Data?
    @State var profilePicture: UIImage?
    @State var showCamera = false
    @State var errorMessage = ""
    @State var errorIsVisible = false
    @State var editProfileSuccessful = false
    
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
                        selected: $spokenLanguages.languages
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
                            guard let selectedImageData = selectedImageData else {
                                errorMessage = "You must complete all the fields"
                                errorIsVisible = true
                                return
                            }
                            
                            if profilePicture != nil, !aboutText.isEmpty, !country.isEmpty, !city.isEmpty, !job.isEmpty, !spokenLanguages.languages.isEmpty {
                                
                                let userDetails = UserDetailsData(about: aboutText, country: country, city: city, job: job, profileImage: selectedImageData, spokenLanguages: languages.languagesList.map({ $0.name }))
                                
                                profilePicture = nil
                                self.selectedImageData = nil
                                
                                editProfileViewModel.editProfile(userDetails: userDetails)
                            } else {
                                errorMessage = "You must complete all the fields"
                                errorIsVisible = true
                            }
                        } label: {
                            Text("Save")
                        }
                        .padding()
                        .cornerRadius(8)
                        .buttonStyle(OutlineBorder(color: .blue))
                        Spacer()
                    }.onReceive(editProfileViewModel.$response) { response in
                        guard let userDetails = response.0 else {
                            
                            guard let error = response.1 else {
                                return
                            }
                            
                            errorMessage = error.getErrorMessage()
                            errorIsVisible = true
                            
                            return
                        }
                        
                        selectedImageData = userDetails.profileImage
                        
                        guard let selectedImageData = selectedImageData else {
                            return
                        }
                        
                        profilePicture = UIImage(data: selectedImageData)
                        userInfo = userDetails
                        editProfileSuccessful = true
                        
                    }
                    .alert(errorMessage, isPresented: $errorIsVisible) {
                        Button("OK", role: .cancel) { }
                    }
                    .alert("Edit successfully done", isPresented: $editProfileSuccessful) {
                        Button("Ok", role: .cancel) {
                        }
                    }
                }
            }.padding()
        }
        .padding(.top, 4)
    }
    
    init(userInfo: Binding<UserDetailsData?>) {
        _userInfo = userInfo
        
        guard let userInfo = self.userInfo else {
            _aboutText = State(initialValue: aboutPlaceholder)
            return
        }
        
        _aboutText = State(initialValue: aboutPlaceholder)
        
        _selectedImageData = State(initialValue: userInfo.profileImage)
        print(userInfo.profileImage)
        guard let selectedImageData = self.selectedImageData else {
            return
        }
        
        _profilePicture = State(initialValue: UIImage(data: selectedImageData))
        _city = State(initialValue: userInfo.city)
        _country = State(initialValue: userInfo.country)
        _job = State(initialValue: userInfo.job)
        var userLanguages = Set<Language>()
        
        userInfo.spokenLanguages.forEach { language in
            userLanguages.insert(Language(name: language))
        }
        
        _spokenLanguages = State(initialValue: SpokenLanguages(name: "", languages: userLanguages))
    }
    
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile(userInfo: .constant(nil))
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
