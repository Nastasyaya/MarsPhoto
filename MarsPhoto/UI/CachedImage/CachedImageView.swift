//
//  CachedImageView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 27.08.2024.
//

import SwiftUI

struct CachedImageView: View {
    @StateObject var viewModel: CachedImageViewModel

    var body: some View {
        switch viewModel.state {
        case .image(let uiImage):
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 130, height: 130)
                .onTapGesture {
                    viewModel.imageTapped(image: uiImage)
                }
        case .empty:
            Color.red
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 130, height: 130)
        }
    }
}

#Preview {
    CachedImageView(
        viewModel: CachedImageViewModel(
            service: NetworkServiceImp.shared,
            url: "",
            onImageShown: { _ in }
        )
    )
}
