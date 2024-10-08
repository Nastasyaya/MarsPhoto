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
                        .disabled(viewModel.isDatePickerShown)

                    makeHistoryButton()
                        .position(
                            x: geometry.size.width * 0.88,
                            y: geometry.size.height * 0.93
                        )
                        .disabled(viewModel.isDatePickerShown)

                    if viewModel.isDatePickerShown {
                        Color.black
                            .ignoresSafeArea()
                            .opacity(0.4)
                    }

                    DatePickerView(
                        isDatePickerShown: $viewModel.isDatePickerShown,
                        selectedDate: $viewModel.selectedDate,
                        onClose: viewModel.closeDatePickerTapped,
                        onConfirm: viewModel.confirmSelectedDate
                    )
                }
            }
        }
    }

    private func makeMainContent(
        from model: HomeViewModel.Content
    ) -> some View {
        VStack {
            HomeNavigationBarView(
                onShowDatePicker: {
                    viewModel.isDatePickerShown.toggle()
                },
                onShowFilter: viewModel.filterTapped
            )

            ScrollView {
                VStack {
                    ForEach(model.cards) { card in
                        CardView(viewModel: card)
                    }
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
            parameters: HomeViewModel.Parameters(
                onFilterShown: { _ in },
                onImageShown: {
                    url in
                    print(url)
                },
                onHistoryShown: { information in
                    print(information.count)
                }
            ),
            service: NetworkServiceImp.shared
        )
    )
}
