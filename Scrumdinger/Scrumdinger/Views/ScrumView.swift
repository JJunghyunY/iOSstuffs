//
//  ScrumView.swift
//  Scrumdinger
//
//  Created by Junyoo on 2/7/24.
//

import SwiftUI

struct ScrumView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView = false
    
    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: { isPresentingNewScrumView = true }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumView(scrums: $scrums,
                         isPresentingNewScrumView: $isPresentingNewScrumView)
        }
    }
}

#Preview {
    ScrumView(scrums: .constant(DailyScrum.sampleData))
}
