//
//  HistoryViewModel.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import Foundation

final class HistoryViewModel {
    private let onBack: () -> Void

    init(onBack: @escaping () -> Void) {
        self.onBack = onBack
    }

    func backTapped() {
        onBack()
    }
}
