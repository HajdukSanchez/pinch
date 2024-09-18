//
//  PageModel.swift
//  Pinch
//
//  Created by Jozek Andrzej Hajduk Sanchez on 18/09/24.
//

import Foundation

struct PageModel: Identifiable {
    let id: Int
    let imageName: String
}

extension PageModel {
    // Get the thumbnail name of the image
    var thumbNailName: String {
        return "thumb-\(imageName)"
    }
}
