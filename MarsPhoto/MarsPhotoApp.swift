//
//  MarsPhotoApp.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 23.08.2024.
//

import SwiftUI

@main
struct MarsPhotoApp: App {
    @State private var path: [MarsPhotoDestination] = []

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                HomeFlow(
                    onBack: {
                        path.removeLast()
                    },
                    onHistoryShown: { information in
                        path.append(.history(information: information))
                    }
                )
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
