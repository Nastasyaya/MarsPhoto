//
//  HistoryContentConverter.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 26.08.2024.
//

import Foundation

protocol HistoryContentConverter {
    func convert(from photos: [Photo]) -> [HistoryCardViewModel]
}

struct HistoryContentConverterImp: HistoryContentConverter {
    func convert(from photos: [Photo]) -> [HistoryCardViewModel] {
        photos.map { photo in
            HistoryCardViewModel(
                id: photo.id,
                rover: photo.rover.name.rawValue,
                camera: photo.camera.fullName,
                date: photo.earthDate
            )
        }
    }
}
