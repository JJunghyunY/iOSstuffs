//
//  TestingApp.swift
//  Testing
//
//  Created by Junyoo on 2/15/24.
//

import SwiftUI

@main
struct TestingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
