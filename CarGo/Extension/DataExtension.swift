//
//  ImageExtension.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation
import SwiftUI

extension Data {
    
    func imageFromData() -> Image {
        let profilePicture = UIImage(data: self)
        
        guard let profilePicture = profilePicture else {
            return Image(systemName: "person.circle")
        }
        
        return Image(uiImage: profilePicture)
    }
}
