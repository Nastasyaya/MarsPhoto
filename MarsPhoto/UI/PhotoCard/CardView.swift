//
//  CardView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 24.08.2024.
//

import SwiftUI

struct CardView: View {
    let viewModel: CardViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(.backgroundOne)
                .frame(height: 150)
                .shadow(color: Color.black.opacity(0.08), radius: 16, x: 0, y: 3)
            
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    CardRowView(label: "Rover:", caption: viewModel.roverCaption)
                    
                    CardRowView(label: "Camera:", caption: viewModel.cameraCaption)
                    
                    CardRowView(label: "Date:", caption: viewModel.dateCaption)
                }
                
                Spacer()
                
                CachedImageView(
                    viewModel: CachedImageViewModel(
                        service: NetworkServiceImp.shared,
                        url: viewModel.image,
                        onImageShown: viewModel.onImageShown
                    )
                )
            }
            .padding(EdgeInsets(top: 26, leading: 16, bottom: 26, trailing: 10))
        }
    }
}

#Preview {
    ZStack {
        Color.green
            .ignoresSafeArea()
        CardView(
            viewModel: CardViewModel(
                id: 1,
                cameraCaption: "cameraCaption",
                roverCaption: "roverCaption",
                dateCaption: "dateCaption",
                image: "image",
                onImageShown: { _ in }
            )
        )
    }
}
