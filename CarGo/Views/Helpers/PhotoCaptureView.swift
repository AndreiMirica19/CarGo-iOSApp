//
//  PhotoCaptureView.swift
//  CarGo
//
//  Created by Andrei Mirica on 08.02.2023.
//

import SwiftUI

struct PhotoCaptureView: View {
    
    @Binding var showImagePicker: Bool
    @Binding var imageData: Data?
    @Binding var image: UIImage?

    var body: some View {
        ImagePicker(isShown: $showImagePicker, imageData: $imageData, image: $image)
        
    }
}

struct PhotoCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCaptureView(showImagePicker: .constant(false), imageData: .constant(nil), image: .constant(nil))
    }
}
