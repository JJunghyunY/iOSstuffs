//
//  NewScrumView.swift
//  Scrumdinger
//
//  Created by Junyoo on 2/11/24.
//

import SwiftUI

struct NewScrumView: View {
    @State private var newScrum = DailyScrum.emptyScrum
    @Binding var scrums: [DailyScrum]
    @Binding var isPresentingNewScrumView: Bool
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismissNewScrumView()
                        } label: {
                            Text("Dissmiss")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            scrums.append(newScrum)
                            dismissNewScrumView()
                        } label: {
                            Text("Add")
                        }
                    }
                }
                .navigationTitle(Text("NewScrum"))
        }
    }
    
    private func dismissNewScrumView() {
        isPresentingNewScrumView = false
    }
}

#Preview {
    NewScrumView(scrums: .constant(DailyScrum.sampleData), isPresentingNewScrumView: .constant(true))
}
