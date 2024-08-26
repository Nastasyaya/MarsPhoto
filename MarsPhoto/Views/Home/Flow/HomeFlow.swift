//
//  HomeFlow.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import SwiftUI

struct HomeFlow: View {
    let onBack: () -> Void
    let onHistoryShown: (_ information: [Photo]) -> Void

    var body: some View {
        makeHomeView(
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
    }
}

// MARK: - HomeView
private extension HomeFlow {
    func makeHomeView(
        onHistoryShown: @escaping (
            _ information: [Photo]
        ) -> Void
    ) -> some View {
        HomeView(
            viewModel: HomeViewModel(
                contentConverter: HomeContentConverterImp(),
                service: NetworkServiceImp(),
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
