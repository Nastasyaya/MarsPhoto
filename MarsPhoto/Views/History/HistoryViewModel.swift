//
//  HistoryViewModel.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import Foundation

final class HistoryViewModel: ObservableObject {
    enum State {
        case empty
        case content([HistoryCardViewModel])
    }
    
    @Published private(set) var state: State = .empty
    
    private let onBack: () -> Void

    init(
        contentConverter: HistoryContentConverter,
        information: [Photo],
        onBack: @escaping () -> Void
    ) {
        self.onBack = onBack
        
        guard information.isEmpty else {
            state = .content(contentConverter.convert(from: information))
            return
        }
        state = .empty
    }

    func backTapped() {
        onBack()
    }

}
