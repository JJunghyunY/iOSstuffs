//
//  ContentView.swift
//  DynamicType
//
//  Created by Junyoo on 2/11/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        
        let dynamicHStack = dynamicTypeSize <= .xxxLarge ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
        
        let dynamicVStack = dynamicTypeSize <= .xxxLarge ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())

        dynamicHStack {
            
            Spacer()
            
            dynamicVStack {
                Image(systemName: "1.circle.fill")
                    .font(.headline)
                Text("one")
                    .font(.caption)
            }
            .padding(5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(in:RoundedRectangle(cornerRadius: 8))
            
            dynamicVStack {
                Image(systemName: "2.circle.fill")
                    .font(.headline)
                Text("two")
                    .font(.caption)
            }
            .padding(5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(in:RoundedRectangle(cornerRadius: 8))
            
            dynamicVStack {
                Image(systemName: "3.circle.fill")
                    .font(.headline)
                Text("three")
                    .font(.caption)
            }
            .padding(5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(in:RoundedRectangle(cornerRadius: 8))
            
            dynamicVStack {
                Image(systemName: "4.circle.fill")
                    .font(.headline)
                Text("four")
                    .font(.caption)
            }
            .padding(5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(in:RoundedRectangle(cornerRadius: 8))
            
            dynamicVStack {
                Image(systemName: "5.circle.fill")
                    .font(.headline)
                Text("five")
                    .font(.caption)
            }    
            .padding(5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(in:RoundedRectangle(cornerRadius: 8))
            
            Spacer()
            
        }
        .padding(4)
        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        .foregroundStyle(.primary)
        .backgroundStyle(.quaternary)
        
        Spacer()
    }
}

#Preview {
    ContentView()
}
