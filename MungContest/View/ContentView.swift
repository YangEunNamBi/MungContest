//
//  ContentView.swift
//  MungContest
//
//  Created by Hyun Jaeyeon on 6/1/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var navigationManager = NavigationManager()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack {
                Text("여기는 실제로 보이지 않는 화면입니다.")
                Button("대회 설정 화면으로") {
                    navigationManager.push(to: .plan)
                }
            }
            .navigationDestination(for: PathType.self) { pathType in
                pathType.NavigatingView()
            }
        }
        .environment(navigationManager)
        
    }
}

#Preview {
    ContentView()
}
