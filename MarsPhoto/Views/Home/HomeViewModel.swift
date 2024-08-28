//
//  HomeViewModel.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 23.08.2024.
//

import Combine
import Foundation
import UIKit

final class HomeViewModel: ObservableObject {
    enum State {
        case loading
        case content(Content)
    }

    struct Content {
        let cards: [CardViewModel]
    }
    
    struct Parameters {
        let onFilterShown: (FilterType) -> Void
        let onImageShown: (_ image: UIImage) -> Void
        let onHistoryShown: (_ information: [Photo]) -> Void
    }

    @Published var isDatePickerShown: Bool = false
    @Published var selectedDate: Date = .now
    @Published private(set) var state: State = .loading

    private var photos: [Photo] = []

    private let contentConverter: HomeContentConverter
    private let parameters: Parameters
    private let service: NetworkService

    init(
        contentConverter: HomeContentConverter,
        parameters: Parameters,
        service: NetworkService
    ) {
        self.contentConverter = contentConverter
        self.parameters = parameters
        self.service = service

        fetchMarsDataResponse()
    }
}

// MARK: - Actions
extension HomeViewModel {
    func filterTapped(type: FilterType) {
        switch type {
        case .camera:
            let cameraElements = photos
                .map { $0.rover.cameras }
                .first
            parameters.onFilterShown(
                .camera(
                    elements: cameraElements ?? [],
                    onFiltered: { name in
                        print(name)
                    }
                )
            )
        case .rover:
            break
        }
    }

    func historyTapped() {
        parameters.onHistoryShown(photos)
    }
    
    func closeDatePickerTapped() {
        isDatePickerShown = false
    }
    
    func confirmSelectedDate(date: Date) {
        isDatePickerShown = false
        print(date)
    }
}

// MARK: - FetchMarsDataResponse
private extension HomeViewModel {
    func fetchMarsDataResponse() {
        service.fetchMarsDataResponse(
            sol: "1000",
            page: "2",
            completion: { [weak self] result in
                self?.handleMarsDataResponse(from: result)
            }
        )
    }

    func handleMarsDataResponse(
        from response: Result<PhotosResponse, MarsPhotosError>
    ) {
        DispatchQueue.main.async { [weak self] in
            switch response {
            case .success(let response):
                self?.handleSuccessResponse(with: response.photos)
            case .failure(_):
                self?.state = .loading
            }
        }
    }
    
    func handleSuccessResponse(with photos: [Photo]) {
        self.photos = photos
        state = .content(
            contentConverter.convert(
                from: photos,
                onImageShown: parameters.onImageShown
            )
        )
    }
}
