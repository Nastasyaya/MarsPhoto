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
        case .content:
            EmptyView()
        }
    }
}

#Preview {
    HomeView(
        viewModel: HomeViewModel(
            service: NetworkServiceImp()
        )
    )
}
