//
//  CardRowView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 24.08.2024.
//

import SwiftUI

struct CardRowView: View {
    let label: String
    let caption: String
    
    var body: some View {
        Text(
            "\(Text(label).foregroundStyle(Color.layerTwo).fontWeight(.regular)) \(caption)"
        )
            .fontWeight(.bold)
            .tint(Color.layerOne)
    }
}

#Preview {
    CardRowView(label: "Rover:", caption: "Front Hazard Avoidance Camera")
}
