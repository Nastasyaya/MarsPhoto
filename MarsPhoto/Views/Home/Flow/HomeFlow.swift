//
//  HomeFlow.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import SwiftUI

struct HomeFlow: View {
    @State private var isHistoryShown: Bool = false

    var body: some View {
        makeHomeView(
            onHistoryShown: {
                isHistoryShown = true
            }
        )
        .navigationDestination(isPresented: $isHistoryShown) {
            makeHistoryView(
                onBack: {
                    isHistoryShown = false
                }
            )
        }
    }
}

// MARK: - HomeView
private extension HomeFlow {
    func makeHomeView(
        onHistoryShown: @escaping () -> Void
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
        onBack: @escaping () -> Void
    ) -> some View {
        HistoryView(
            viewModel: HistoryViewModel(
                onBack: onBack
            )
        )
    }
}
