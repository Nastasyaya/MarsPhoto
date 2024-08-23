//
//  MarsPhotoApp.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 23.08.2024.
//

import SwiftUI

@main
struct MarsPhotoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
