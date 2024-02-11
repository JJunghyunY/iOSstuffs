//
//  CardView.swift
//  Scrumdinger
//
//  Created by Junyoo on 2/7/24.
//

import SwiftUI

struct CardView: View {
    let scrum: DailyScrum

    var body: some View {
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            //heading을 추가로 읽어줌, 시각장애인이 헤더를 식별하는데 도움을 줌
            
            Spacer()
            HStack {
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                    .accessibilityLabel("\(scrum.attendees.count) attendees")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                    .accessibilityLabel("\(scrum.lengthInMinutes) minute meeting")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
    }
}

#Preview {
    var scrum: DailyScrum = DailyScrum.sampleData[0]
    return CardView(scrum: scrum)
        .background(scrum.theme.mainColor)
        .previewLayout(.fixed(width: 400, height: 60))
}
/*
 
 PreviewProvider가 아닌 Preview Macro쓸때 view 반환
 
 @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, xrOS 1.0, *)
 struct $s11Scrumdinger33_B288C20EF69C818EEA02D190BD1088DALl7PreviewfMf_15PreviewRegistryfMu_: DeveloperToolsSupport.PreviewRegistry {
     static let fileID: String = "Scrumdinger/CardView.swift"
     static let line: Int = 18
     static let column: Int = 1

     static func makePreview() throws -> DeveloperToolsSupport.Preview {
         DeveloperToolsSupport.Preview {
             var scrum = DailyScrum.sampleData[0]
             CardView(scrum: scrum)
                 .background(scrum.theme.mainColor)
                 .previewLayout(.fixed(width: 400, height: 60))
         }
     }
 }

*/

