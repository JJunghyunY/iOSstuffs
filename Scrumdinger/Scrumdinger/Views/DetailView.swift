//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Junyoo on 2/7/24.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var editScrum = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundStyle(Color.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
            } header: {
                Text("Meeting Info")
            }
            .accessibilityElement(children: .combine)
            //해당 section을 하나로 결합해서 voice over에서 한번에 다 읽힘
            HStack {
                Label("Theme", systemImage: "paintpalette")
                Spacer()
                Text(scrum.theme.name)
                    .padding(4)
                    .foregroundStyle(scrum.theme.accentColor)
                    .background(scrum.theme.mainColor)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            .accessibilityElement(children: .combine)
            
            Section {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            } header: {
                Text("Attendees")
            }
            
            Section {
                if scrum.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.history) { history in
                    HStack {
                        Image(systemName: "calendar")
                        Text(history.date, style: .date)
                    }
                }
            } header: {
                Text("History")
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button {
                isPresentingEditView = true
                editScrum = scrum
            } label: {
                Text("Edit")
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(scrum: $editScrum)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                isPresentingEditView = false
                            } label: {
                                Text("Cancel")
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button {
                                isPresentingEditView = false
                                scrum = editScrum
                            } label: {
                                Text("Done")
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
