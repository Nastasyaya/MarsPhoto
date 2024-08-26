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
        ZStack {
            mainContent
        }
        .padding(
            EdgeInsets(
                top: 2,
                leading: 20,
                bottom: 20,
                trailing: 20
            )
        )
        .background {
            Color.accentOne
                .ignoresSafeArea(edges: .top)
        }
        .navigationBarBackButtonHidden(true)
        
        Spacer()
        
        Group {
            switch viewModel.state {
            case .empty:
                Image("emptyHistory")
            case .content(let photos):
                ScrollView {
                    ForEach(photos) {
                        HistoryCardView(viewModel: $0)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        
        Spacer()
    }
    
    private var mainContent: some View {
        HStack {
            Spacer()
            
            Text("History")
                .foregroundStyle(.layerOne)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
        }
        .overlay(alignment: .leading) {
            Button(
                action: viewModel.backTapped,
                label: {
                    Image("leftChevrone")
                }
            )
        }
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
