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

    private var filteredResult: [Photo] = []
    private let subject = CurrentValueSubject<[Photo], Never>([])

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
        observePhotosSubject()
    }
}

// MARK: - Actions
extension HomeViewModel {
    func filterTapped(type: FilterType) {
        switch type {
        case .camera:
            let cameraElements = subject.value
                .map { $0.rover.cameras }
                .first
            parameters.onFilterShown(
                .camera(
                    elements: cameraElements ?? [],
                    onFiltered: { [weak self] name in
                        self?.filteredResult = self?.subject.value
                            .filter { $0.camera.name == name } ?? []
                    }
                )
            )
        case .rover:
            break
        }
    }

    func historyTapped() {
        parameters.onHistoryShown(subject.value)
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
        switch response {
        case .success(let model):
            subject.send(model.photos)
        case .failure(_):
            DispatchQueue.main.async { [weak self] in
                self?.state = .loading
            }
        }
    }
}

// MARK: - ObservePhotosSubject
private extension HomeViewModel {
    func observePhotosSubject() {
        subject
            .map { [weak self] photos in
                guard let self = self else {
                    return Content(cards: [])
                }
                return self.contentConverter.convert(
                    from: photos,
                    onImageShown: self.parameters.onImageShown
                )
            }
            .map { .content($0) }
            .receive(on: DispatchQueue.main)
            .assign(to: &$state)
    }
}
