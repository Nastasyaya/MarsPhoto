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

    private let contentConverter: HomeContentConverter
    private let service: NetworkService
    private let onHistoryShown: () -> Void

    init(
        contentConverter: HomeContentConverter,
        service: NetworkService,
        onHistoryShown: @escaping () -> Void
    ) {
        self.contentConverter = contentConverter
        self.service = service
        self.onHistoryShown = onHistoryShown

        fetchMarsDataResponse()
    }

    func historyTapped() {
        onHistoryShown()
    }
}

private extension HomeViewModel {
    func fetchMarsDataResponse() {
        service.fetchMarsDataResponse(
            sol: "1000",
            page: "1",
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
            state = .content(contentConverter.convert(from: model))
        case .failure(_):
            state = .loading
        }
    }
}
