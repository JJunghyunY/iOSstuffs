//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Junyoo on 2/7/24.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondElapsed: Int
    let secondRemaining: Int
    let theme: Theme
    
    private var totalSeconds: Int {
        secondElapsed + secondRemaining
    }
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondElapsed) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
        secondRemaining / 60
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(secondRemaining)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal])
    }
}

#Preview {
    MeetingHeaderView(secondElapsed: 60, secondRemaining: 180, theme: .bubblegum)
        .previewLayout(.sizeThatFits)
}
