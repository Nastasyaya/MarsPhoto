//
//  FilterType.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 28.08.2024.
//

import Foundation

enum FilterType {
    case camera(
        elements: [Rover.CameraElement],
        onFiltered: (String) -> Void
    )
    case rover
}

extension FilterType: Identifiable {
    var id: UUID {
        UUID()
    }
}
