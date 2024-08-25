//
//  PhotoView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import SwiftUI

struct PhotoView: View {
    @State private var isAnimated: Bool
    @State private var imageScale: CGFloat
    @State private var imageOffset: CGSize
    
    init(
        isAnimated: Bool = true,
        imageScale: CGFloat = 1,
        imageOffset: CGSize = .zero
    ) {
        self.isAnimated = isAnimated
        self.imageScale = imageScale
        self.imageOffset = imageOffset
    }
    
    var body: some View {
        ZStack {
            Color.layerOne
                .ignoresSafeArea()
            
            // MARK: - IMAGE
            Image("marsImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(isAnimated ? 1 : 0)
                .offset(x: imageOffset.width,
                        y: imageOffset.height)
                .scaleEffect(imageScale)
            
            // MARK: - 1. TAP GESTURE
                .onTapGesture(count: 2, perform: {
                    if imageScale == 1 {
                        withAnimation(.spring()) {
                            imageScale = 3
                        }
                    } else {
                        resetImageState()
                    }
                })
            
            // MARK: - 2. DRAG GESTURE
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                imageOffset = value.translation
                            }
                        }
                        .onEnded { _ in
                            if imageScale <= 1 {
                                resetImageState()
                            }
                        }
                )
            // MARK: - 3. MAGNIFICATION
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                if imageScale >= 1 && imageScale <= 2 {
                                    imageScale = value
                                } else if imageScale > 3 {
                                    imageScale = 2
                                }
                            }
                        }
                )
        }
    }
    private func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
}

#Preview {
    PhotoView()
}

