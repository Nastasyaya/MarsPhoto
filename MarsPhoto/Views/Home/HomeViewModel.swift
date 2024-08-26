//
//  HomeViewModel.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 23.08.2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    enum State {
        case loading
        case content(Content)
    }

    struct Content {
        let cards: [CardViewModel]
    }

    @Published private(set) var state: State = .loading

    private var photos: [Photo] = []

    private let contentConverter: HomeContentConverter
    private let service: NetworkService
    private let onHistoryShown: (_ information: [Photo]) -> Void

    init(
        contentConverter: HomeContentConverter,
        service: NetworkService,
        onHistoryShown: @escaping (_ information: [Photo]) -> Void
    ) {
        self.contentConverter = contentConverter
        self.service = service
        self.onHistoryShown = onHistoryShown

        fetchMarsDataResponse()
    }

    func historyTapped() {
        onHistoryShown(photos)
    }
}

private extension HomeViewModel {
    func fetchMarsDataResponse() {
        service.fetchMarsDataResponse(
            sol: "1000",
            page: "2",
            completion: { result in
                DispatchQueue.main.async { [weak self] in
                    self?.handleMarsDataResponse(from: result)
                }
            }
        )
    }

    func handleMarsDataResponse(
        from response: Result<PhotosResponse, MarsPhotosError>
    ) {
        switch response {
        case .success(let model):
            photos = model.photos
            state = .content(contentConverter.convert(from: model.photos))
        case .failure(_):
            state = .loading
        }
    }
}
