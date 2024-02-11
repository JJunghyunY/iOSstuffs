//
//  ScrumProgressViewStyle.swift
//  Scrumdinger
//
//  Created by Junyoo on 2/7/24.
//

import SwiftUI

struct ScrumProgressViewStyle: ProgressViewStyle {
    var theme: Theme
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(theme.accentColor)
                .frame(height: 20)
            ProgressView(configuration)
                .tint(theme.mainColor)
                .frame(height: 12)
                .padding(.horizontal)
        }
    }
}

#Preview {
    ProgressView(value: 0.4)
        .progressViewStyle(ScrumProgressViewStyle(theme: .buttercup))
        .previewLayout(.sizeThatFits)
}
