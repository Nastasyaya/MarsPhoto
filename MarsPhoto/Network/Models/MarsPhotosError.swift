//
//  MarsPhotosError.swift
//  MarsCamera
//
//  Created by Анастасия Кутняхова on 23.08.2024.
//

import Foundation

enum MarsPhotosError: Error {
    case invalidRequest
    case missingData
    case missingResponse
    case missingTask
    case jsonDecodeFailed
}
