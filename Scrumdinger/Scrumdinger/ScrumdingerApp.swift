//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Junyoo on 2/7/24.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            ScrumView(scrums: $scrums)
        }
    }
}
