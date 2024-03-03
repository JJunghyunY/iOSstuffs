//
//  CellView.swift
//  illillillill
//
//  Created by Junyoo on 11/11/23.
//

import SwiftUI

struct CellView: View {
    @Binding var cell: Cell

    var color: Color {
        cell.isAlive ? Color.white : Color.black
    }

    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .onTapGesture {
                cell.isAlive.toggle()
            }
    }
}

#Preview {
    CellView(cell: .constant(Cell()))
}




















