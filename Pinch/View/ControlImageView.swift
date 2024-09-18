//
//  ControlImageView.swift
//  Pinch
//
//  Created by Jozek Andrzej Hajduk Sanchez on 18/09/24.
//

import SwiftUI

struct ControlImageView: View {
    
    // MARK: - Properties
    
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

#Preview {
    ControlImageView(icon: "minus.magnifyingglass")
        .preferredColorScheme(.dark)
}
