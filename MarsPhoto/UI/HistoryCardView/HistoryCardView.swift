//
//  HistoryCardView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import SwiftUI

struct HistoryCardView: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(.backgroundOne)
                .frame(height: 150)
                .shadow(color: Color.black.opacity(0.08), radius: 16, x: 0, y: 3)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack {
                        Divider()
                            .frame(height: 1)
                            .background(Color.accentOne)
                    }
                    
                    Text("Filters")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.accentOne)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    CardRowView(label: "Rover:", caption: "cnhjsdjh")
                    CardRowView(label: "Camera:", caption: "kskjcskj")
                    CardRowView(label: "Date:", caption: "09.11.2012")
                }
            }
            .padding()
        }
    }
}
#Preview {
    HistoryCardView()
}
