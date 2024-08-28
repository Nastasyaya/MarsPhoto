//
//  HistoryNavBarView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 27.08.2024.
//

import SwiftUI

struct HistoryNavBarView: View {
    let action: () -> Void
    
    var body: some View {
        ZStack {
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
                    action: action,
                    label: {
                        Image("leftChevrone")
                    }
                )
            }
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
        
        Spacer()
    }
}

#Preview {
    HistoryNavBarView(action: {})
}
