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
    @State private var imageOffset: CGSize = .zero
    @State private var isDrawerOpen: Bool = false
    @State private var pageIndex: Int = 0
    
    let pages: [PageModel] = pagesData
    
    // MARK: - Functions
    func resetImageState() {
        return withAnimation(.spring) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    func toggleImageDrawer() {
        withAnimation(.easeOut) {
            isDrawerOpen.toggle()
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                Image(pages[pageIndex].imageName)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2, perform: {
                        if imageScale < 5 {
                            withAnimation(.spring) {
                                imageScale += 2
                            }
                        } else {
                            resetImageState()
                        }
                    })
                    .onTapGesture {
                        if imageScale > 1 {
                            resetImageState()
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = gesture.translation
                                }
                            })
                            .onEnded({ _ in
                                if imageScale == 1 {
                                    resetImageState()
                                }
                            })
                    )
                    .gesture(
                        MagnifyGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = value.magnification
                                    }
                                }
                            })
                            .onEnded({ _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale < 1 {
                                    resetImageState()
                                }
                            })
                    )
            }
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            }
            .overlay(alignment: .top, content: {
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
            })
            .overlay(alignment: .bottom) {
                Group {
                    HStack {
                        Button {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                }
                                if imageScale == 1 {
                                    resetImageState()
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        Button {
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .opacity(isAnimating ? 1 : 0)
                }
                .padding(.bottom, 30)
            }
            .overlay(alignment: .topTrailing) {
                HStack(alignment: .center, spacing: 12) {
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture {
                            toggleImageDrawer()
                        }
                    ForEach(pages) { page in
                        Image(page.thumbNailName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(radius: 4)
                            .opacity(isDrawerOpen ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                            .onTapGesture {
                                if page.id != pageIndex {
                                    isAnimating = true
                                    pageIndex = page.id
                                    toggleImageDrawer()
                                }
                            }
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .opacity(isAnimating ? 1 : 0)
                .frame(width: 260)
                .padding(.top, UIScreen.main.bounds.height / 12)
                .offset(x: isDrawerOpen ? 20 : 215)
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
