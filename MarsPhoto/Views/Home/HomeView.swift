//
//  HomeView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 23.08.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            PreloaderView()
        case let .content(model):
            GeometryReader { geometry in
                ZStack {
                    makeMainContent(from: model)

                    makeHistoryButton()
                        .position(
                            x: geometry.size.width * 0.88,
                            y: geometry.size.height * 0.93
                        )
                }
            }
        }
    }

    private func makeMainContent(
        from model: HomeViewModel.Content
    ) -> some View {
        VStack {
            HomeNavigationBarView()

            ScrollView {
                ForEach(model.cards) {
                    CardView(viewModel: $0)
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 12, trailing: 20))
            }
        }
    }

    private func makeHistoryButton() -> some View {
        Button(
            action: viewModel.historyTapped,
            label: {
                Image("history")
                    .background(
                    Circle()
                        .frame(width: 70, height: 70)
                        .tint(.accentOne)
                    )
            }
        )
    }
}

#Preview {
    HomeView(
        viewModel: HomeViewModel(
            contentConverter: HomeContentConverterImp(),
            service: NetworkServiceImp(),
            onHistoryShown: {
                print("History tapped")
            }
        )
    )
}
