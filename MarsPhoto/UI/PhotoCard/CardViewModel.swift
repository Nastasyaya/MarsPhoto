//
//  CardViewModel.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 24.08.2024.
//

import Foundation
import UIKit

struct CardViewModel: Identifiable {
    let id: Int
    let cameraCaption: String
    let roverCaption: String
    let dateCaption: String
    let image: String
    let onImageShown: (UIImage) -> Void
}
