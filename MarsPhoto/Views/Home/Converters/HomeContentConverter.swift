//
//  HomeContentConverter.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import Foundation
import UIKit

protocol HomeContentConverter {
    func convert(
        from photos: [Photo],
        onImageShown: @escaping (UIImage) -> Void
    ) -> HomeViewModel.Content
}

struct HomeContentConverterImp: HomeContentConverter {
    func convert(
        from photos: [Photo],
        onImageShown: @escaping (UIImage) -> Void
    ) -> HomeViewModel.Content {
        HomeViewModel.Content(
            cards: photos.map { photo in
                CardViewModel(
                    id: photo.id,
                    cameraCaption: photo.camera.fullName,
                    roverCaption: photo.rover.name.rawValue,
                    dateCaption: photo.earthDate,
                    image: photo.imgSrc,
                    onImageShown: onImageShown
                )
            }
        )
    }
}
