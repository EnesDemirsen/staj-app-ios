//
//  ErdemliMahalleMusabakalariApp.swift
//  ErdemliMahalleMusabakalari
//
//  Created by ENES DEMİRŞEN on 30.06.2026.
//

import SwiftUI
import SwiftData

@main
struct ErdemliMahalleMusabakalariApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
