//
//  AddCarPhotos.swift
//  CarGo
//
//  Created by Andrei Mirica on 03.03.2023.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct AddCarPhotos: View {
    
    @EnvironmentObject var router: Router<AddCarPaths>
    @EnvironmentObject var carData: CarData
    private var columnGrid: [GridItem] = [GridItem(.adaptive(minimum: 116)), GridItem(.adaptive(minimum: 116)), GridItem(.adaptive(minimum: 80))]
    @State var addedPhotos: [UIImage] = []
    @State var addedPhotosData: [Data] = []
    @State var presentActionSheet = false
    @State var presentGallery = false
    @State var selectedItem: PhotosPickerItem?
    @State var selectedImageData: Data?
    @State var profilePicture: UIImage?
    @State var showCamera = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Text("Add Car Photos")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    .padding(.top)
                
                Text("Please add up to 15 photos of your car.")
                    .font(.subheadline)
                
                Spacer(minLength: 32)
                
                LazyVGrid(columns: columnGrid) {
                    ForEach(addedPhotos, id: \.self) { image in
                        AddedCarPhotoCell(image: image) {
                            if let index = addedPhotos.firstIndex(of: image) {
                                addedPhotos.remove(at: index)
                            }
                        }
                    }
                    Image(systemName: "plus.square")
                        .resizable()
                        .scaledToFill()
                        .onTapGesture {
                            presentActionSheet = true
                        }
                   
                }
                .padding(.top)
                
                Button {
                    carData.photos = addedPhotosData
                    router.push(.addCarPrice)
                } label: {
                    Text("Next")
                }
                .padding()
                .padding(.top, 32)
                .cornerRadius(8)
                .buttonStyle(OutlineBorder(color: !addedPhotos.isEmpty ? .blue : .gray))
                .disabled(addedPhotos.isEmpty)
                
                .confirmationDialog("", isPresented: $presentActionSheet) {
                    Button("Camera") {
                        showCamera = true
                    }
                    
                    Button("Gallery") {
                        presentGallery = true
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
                            
                            guard let selectedUIImage = UIImage(data: selectedImageData) else {
                                return
                            }
                            
                            addedPhotosData.append(selectedImageData)
                            addedPhotos.append(selectedUIImage)
                        }
                    }
                }
            }.padding(.horizontal, 24)
        }.padding(.top)
    }
}

struct AddCarPhotos_Previews: PreviewProvider {
    static var previews: some View {
        AddCarPhotos()
    }
}
