//
//  HomeFlow.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import SwiftUI

struct HomeFlow: View {
    @State private var image: UIImage?

    let onBack: () -> Void
    let onHistoryShown: (_ information: [Photo]) -> Void

    var body: some View {
        makeHomeView(
            onImageShown: { image in
                self.image = image
            },
            onHistoryShown: onHistoryShown
        )
        .navigationDestination(for: MarsPhotoDestination.self) { destination in
            switch destination {
            case let .history(information):
                makeHistoryView(
                    information: information,
                    onBack: onBack
                )
            }
        }
        .fullScreenCover(item: $image) { image in
            makeFullScreenPhotoView(image: image)
        }
    }
}

extension UIImage: Identifiable {}

// MARK: - HomeView
private extension HomeFlow {
    func makeHomeView(
        onImageShown: @escaping (
            _ image: UIImage
        ) -> Void,
        onHistoryShown: @escaping (
            _ information: [Photo]
        ) -> Void
    ) -> some View {
        HomeView(
            viewModel: HomeViewModel(
                contentConverter: HomeContentConverterImp(),
                service: NetworkServiceImp.shared,
                onImageShown: onImageShown,
                onHistoryShown: onHistoryShown
            )
        )
    }
}

// MARK: - HistoryView
private extension HomeFlow {
    func makeHistoryView(
        information: [Photo],
        onBack: @escaping () -> Void
    ) -> some View {
        HistoryView(
            viewModel: HistoryViewModel(
                contentConverter: HistoryContentConverterImp(),
                information: information,
                onBack: onBack
            )
        )
    }
}

// MARK: - FullScreenPhotoView
private extension HomeFlow {
    func makeFullScreenPhotoView(
        image: UIImage
    ) -> some View {
        FullScreenPhotoView(image: image)
    }
}
