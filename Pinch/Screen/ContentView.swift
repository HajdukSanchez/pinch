//
//  ContentView.swift
//  Pinch
//
//  Created by Jozek Andrzej Hajduk Sanchez on 12/09/24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1.0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("magazine-front-cover")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2, perform: {
                        if imageScale < 5 {
                            withAnimation(.spring) {
                                imageScale += 2
                            }
                        } else {
                            withAnimation(.spring) {
                                imageScale = 1
                            }
                        }
                    })
                    .onTapGesture {
                        if imageScale > 1 {
                            withAnimation(.spring) {
                                imageScale = 1
                            }
                        }
                    }
            }
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
