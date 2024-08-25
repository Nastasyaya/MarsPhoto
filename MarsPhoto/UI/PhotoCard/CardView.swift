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
                
                makeImage(from: viewModel.image)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(width: 130, height: 130)
            }
            .padding(EdgeInsets(top: 26, leading: 16, bottom: 26, trailing: 10))
        }
    }
}

@ViewBuilder
private func makeImage(from url: String) -> some View {
    AsyncImage(url: URL(string: url)) { phase in
        switch phase {
        case .empty:
            Color.accentOne
        case .success(let image):
            image
                .resizable()
        case .failure(let error):
            Text(error.localizedDescription)
        @unknown default:
            fatalError("Missing image data")
        }
    }
}

//#Preview {
//    ZStack {
//        Color.green
//            .ignoresSafeArea()
//        CardView()
//    }
//}
