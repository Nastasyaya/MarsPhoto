//
//  PhotoCamera.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 23.08.2024.
//

import Foundation

struct PhotoCamera: Decodable {
    let id: Int
    let name: CameraName
    let roverID: Int
    let fullName: FullName

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}
