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
        case content
    }

    @Published private(set) var state: State = .loading
    
    private let service: NetworkService

    init(service: NetworkService) {
        self.service = service
    }
}

private extension HomeViewModel {
    func fetchMarsDataResponse() {
        service.fetchMarsDataResponse(
            sol: "",
            page: "",
            completion: { result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let success):
                        self?.state = .content
                    case .failure(let failure):
                        self?.state = .loading
                    }
                }
            }
        )
    }
}
