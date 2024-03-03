//
//  GameView.swift
//  illillillill
//
//  Created by Junyoo on 11/11/23.
//

import SwiftUI

struct GameView: View {
    @Binding var cells: [[Cell]]
    @Binding var gameSpeed: Double
    @State private var isGameLoopRunning: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<cells.count, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<self.cells[row].count, id: \.self) { column in
                        CellView(cell: self.$cells[row][column])
                    }
                }
            }
        }
        .onChange(of: gameSpeed) { newValue in
            if newValue > 0 && !isGameLoopRunning {
                loopGame()
            }
        }
    }
    
    private func loopGame() {
        guard gameSpeed > 0, !isGameLoopRunning else { return }

        isGameLoopRunning = true

        DispatchQueue.main.asyncAfter(deadline: .now() + (0.4 / gameSpeed)) {
            var newCells = cells
            let numberOfRows = cells.count
            let numberOfColumns = cells[0].count
            
            for row in 0..<numberOfRows {
                for column in 0..<numberOfColumns {
                    let cell = cells[row][column]
                    let neighbors = self.neighbors(ofRow: row, andColumn: column)
                    let aliveNeighbors = neighbors.filter { $0.isAlive }.count
                    
                    if cell.isAlive {
                        if aliveNeighbors < 2 || aliveNeighbors > 3 {
                            newCells[row][column].isAlive = false
                        }
                    } else if aliveNeighbors == 3 {
                        newCells[row][column].isAlive = true
                    }
                }
            }
            
            cells = newCells
            isGameLoopRunning = false
            if gameSpeed > 0 {
                self.loopGame()
            }
        }
    }

    private func neighbors(ofRow row: Int, andColumn column: Int) -> [Cell] {
        let numberOfRows = cells.count
        let numberOfColumns = cells[0].count
        var neighboringCells = [Cell]()

        for i in max(0, row - 1)...min(row + 1, numberOfRows - 1) {
            for j in max(0, column - 1)...min(column + 1, numberOfColumns - 1) {
                if !(i == row && j == column) {
                    neighboringCells.append(cells[i][j])
                }
            }
        }
        return neighboringCells
    }
}
