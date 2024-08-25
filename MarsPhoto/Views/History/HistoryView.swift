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
            Rectangle()
                .foregroundStyle(.accentOne)
                .ignoresSafeArea()
            
                .navigationBarBackButtonHidden(true)
            //            .toolbar {
            //                ToolbarItem(placement: .principal) {
            //                    Text("History")
            //                        .font(.largeTitle)
            //                        .fontWeight(.bold)
            //                        .foregroundStyle(.layerOne)
            //                }
            
            HStack {
                Text("History")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.layerOne)
                    .padding()
                
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(
                                action: viewModel.backTapped,
                                label: {
                                    Image("leftChevrone")
                                }
                            )
                        }
                    }
            }
        }
        .frame(height: 78)
        
        Spacer()
    }
}

#Preview {
    HistoryView(
        viewModel: HistoryViewModel(onBack: {})
    )
}
