//
//  MainActor.swift
//  Concurrent
//
//  Created by Junyoo on 2/8/24.
//

import SwiftUI

struct MainActorView: View {
    @StateObject private var mainViewModel = MainActorViewModel()
    @StateObject private var crashViewModel = CrashViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(crashViewModel.data)
            Button("Fetch data - Crashed") {
                Task {
                    await crashViewModel.fetchDataWithoutMainActor()
                }
            }
            .padding()
            
            Text(mainViewModel.data)
            Button("Fetch data - MainActor") {
                Task {
                    await mainViewModel.fetchData()
                }
            }

        }
    }
}


@MainActor
class MainActorViewModel: ObservableObject {
    @Published var data: String = "initial from MainActorViewModel"
    
    func fetchData() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        self.data = "Updated"
    }
}


class CrashViewModel: ObservableObject {
    @Published var data: String = "initial from CrashViewModel"
    
    func fetchDataWithoutMainActor() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        DispatchQueue.global().async {
            self.data = "Crashed"
        }
    }

}
