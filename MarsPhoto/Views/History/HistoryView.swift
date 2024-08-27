//
//  HistoryView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import SwiftUI

struct HistoryView: View {
    let viewModel: HistoryViewModel
    
    var body: some View {
        VStack {
            HistoryNavBarView(action: viewModel.backTapped)
            
            Group {
                switch viewModel.state {
                case .empty:
                    Image("emptyHistory")
                    Spacer()
                    
                case .content(let photos):
                    ScrollView {
                        ForEach(photos) {
                            HistoryCardView(viewModel: $0)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HistoryView(
        viewModel: HistoryViewModel(
            contentConverter: HistoryContentConverterImp(),
            information: [],
            onBack: {}
        )
    )
}
