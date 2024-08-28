//
//  HomeFlow.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import SwiftUI

struct HomeFlow: View {
    @State private var filterType: FilterType?
    @State private var image: UIImage?

    let onBack: () -> Void
    let onHistoryShown: (_ information: [Photo]) -> Void

    var body: some View {
        makeHomeView(
            onFilterShown: { type in
                filterType = type
            },
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
        .sheet(item: $filterType) { type in
            FilterView(
                filterType: type,
                onClose: {
                    filterType = nil
                },
                onConfirm: {
                    filterType = nil
                }
            )
            .presentationDetents([.height(306)])
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
        onFilterShown: @escaping (FilterType) -> Void,
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
                parameters: HomeViewModel.Parameters(
                    onFilterShown: onFilterShown,
                    onImageShown: onImageShown,
                    onHistoryShown: onHistoryShown
                ),
                service: NetworkServiceImp.shared
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
