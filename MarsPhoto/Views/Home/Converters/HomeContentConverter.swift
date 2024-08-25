//
//  HomeContentConverter.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import Foundation

protocol HomeContentConverter {
    func convert(from model: PhotosResponse) -> HomeViewModel.Content
}

struct HomeContentConverterImp: HomeContentConverter {
    func convert(from model: PhotosResponse) -> HomeViewModel.Content {
        HomeViewModel.Content(
            cards: model.photos.map { photo in
                CardViewModel(
                    id: photo.id,
                    cameraCaption: photo.camera.fullName,
                    roverCaption: photo.rover.name.rawValue,
                    dateCaption: photo.earthDate,
                    image: photo.imgSrc
                )
            }
        )
    }
}
