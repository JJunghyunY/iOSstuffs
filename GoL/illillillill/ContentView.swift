//
//  ContentView.swift
//  illillillill
//
//  Created by Junyoo on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var cells: [[Cell]] = Array(repeating: Array(repeating: Cell(),count: 36), count: 78)
    @State private var gameSpeed = 0.0
    @State private var swipeMessage = ""
    @State private var showingMessage = false
    @State private var isFirstLaunch = true
    @State private var scale: CGFloat = 1.0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            GameView(cells: $cells, gameSpeed: $gameSpeed)
                .scaleEffect(scale)

            Text(swipeMessage)
                .opacity(showingMessage ? 1 : 0)
                .animation(.easeInOut, value: showingMessage)
                .foregroundColor(.white)
                .fontDesign(.rounded)
                .font(.largeTitle)
            
            if isFirstLaunch {
                Image("Onboarding")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .onTapGesture {
            isFirstLaunch = false
        }
        .gesture(
            DragGesture(minimumDistance: 30, coordinateSpace: .local)
                .onChanged { value in
                    updateSwipeMessage(for: value.translation)
                    isFirstLaunch = false
                }
                .onEnded { value in
                    handleSwipe(value.translation)
                }
        )
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    self.scale = value
                }
                .onEnded { _ in
                    if self.scale < 1 {
                        self.scale = 1
                    }
                }
        )
    }
    
    private func updateSwipeMessage(for translation: CGSize) {
        var predictedSpeed = gameSpeed
        
        if abs(translation.width) > abs(translation.height) {
            if translation.width > 0 && gameSpeed < 4 {
                predictedSpeed = gameSpeed + 1
            } else if translation.width < 0 && gameSpeed > 0 {
                predictedSpeed = gameSpeed - 1
            }
        }
        
        if predictedSpeed == 0 {
            swipeMessage = "Pause"
        } else {
            swipeMessage = "Speed \(Int(predictedSpeed))"
        }
        showingMessage = true
    }
    
    private func handleSwipe(_ translation: CGSize) {
        showingMessage = false
        
        if abs(translation.width) > abs(translation.height) {
            if translation.width > 0 && gameSpeed < 4 {
                gameSpeed += 1
            } else if translation.width < 0 && gameSpeed > 0 {
                gameSpeed -= 1
            }
        } else {
            if translation.height > 0 {
                reset()
            } else {
                randomSeed()
            }
        }
    }

    private func reset() {
        cells = Array(repeating: Array(repeating: Cell(), count: 36), count: 78)
        gameSpeed = 0.0
    }
    
    private func randomSeed() {
        cells = Array(repeating: Array(repeating: Cell(), count: 36), count: 78)
        for row in 0..<cells.count {
            for column in 0..<cells[row].count {
                cells[row][column].isAlive = Int.random(in: 1...100) >= 80
            }
        }
        gameSpeed = 0.0
    }
}

#Preview {
    ContentView()
}
