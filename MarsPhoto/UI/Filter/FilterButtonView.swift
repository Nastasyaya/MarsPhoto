//
//  FilterButtonView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import SwiftUI

struct FilterButtonView: View {
    let action: () -> Void
    let imageName: String
    
    var body: some View {
        Button(
            action: action,
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.backgroundOne)
                        .frame(height: 38)
                    
                    HStack {
                        Image(imageName)
                            .frame(width: 24, height: 24)
                        
                        Text("All")
                            .fontWeight(.bold)
                            .tint(.layerOne)
                        Spacer()
                    }
                    .padding(7)
                }
                .padding(.trailing, 12)
            }
        )
    }
}

#Preview {
    ZStack {
        Color.gray
            .ignoresSafeArea()
        
        FilterButtonView(action: {}, imageName: "rover")
    }
}
