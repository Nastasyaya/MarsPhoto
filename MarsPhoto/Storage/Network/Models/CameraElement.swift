//
//  CameraElement.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 23.08.2024.
//

import Foundation

struct CameraElement: Decodable {
    let name: CameraName
    let fullName: FullName

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}
