//
//  AddedCarPhotoCell.swift
//  CarGo
//
//  Created by Andrei Mirica on 03.03.2023.
//

import SwiftUI

struct AddedCarPhotoCell: View {
    let image: UIImage
    @State var showConfirmationDialog = false
    var deleteCell: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Image(uiImage: image)
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(16)
            
            Image("trash.circle.fill")
                .resizable()
                .background(.white)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 32, height: 32)
                .foregroundColor(.red)
                .onTapGesture {
                    showConfirmationDialog = true
                }
                .alert("Are you sure you want to delete this item?", isPresented: $showConfirmationDialog) {
                    Button("Delete", role: .destructive) {
                        self.deleteCell()
                    }
                    Button("Cancel", role: .cancel) {
                        
                    }
                }
        }
        
    }
}

struct AddedCarPhotoCell_Previews: PreviewProvider {
    static var previews: some View {
        AddedCarPhotoCell(image: UIImage(systemName: "plus") ?? UIImage()) {
            
        }
            .frame(width: 116, height: 116)
    }
}
