//
//  CachedImageViewModel.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 27.08.2024.
//

import Foundation
import UIKit

final class CachedImageViewModel: ObservableObject {
    enum State {
        case image(UIImage)
        case empty
    }

    @Published private(set) var state: State = .empty

    private let service: NetworkService
    private let onImageShown: (UIImage) -> Void

    init(
        service: NetworkService,
        url: String,
        onImageShown: @escaping (UIImage) -> Void
    ) {
        self.service = service
        self.onImageShown = onImageShown

        fetchImage(url: url)
    }
    
    func imageTapped(image: UIImage) {
        onImageShown(image)
    }
}

// MARK: - FetchImage
private extension CachedImageViewModel {
    func fetchImage(url: String) {
        service.fetchImage(url: url) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let image):
                    self?.state = .image(image)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.state = .empty
                }
            }
        }
    }
}
