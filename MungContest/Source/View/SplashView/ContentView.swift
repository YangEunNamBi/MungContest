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
            ZStack {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color.black.opacity(0), location: 0.00),
                        Gradient.Stop(color: Color.black.opacity(0.2), location: 0.30),
                        Gradient.Stop(color: Color.accentColor.opacity(0.2), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
                .ignoresSafeArea()
                
                VStack {
                    Text("mung \ncontest")
                        .font(Font.custom("Poppins-Bold", size: 36))
                }
                .navigationDestination(for: PathType.self) { pathType in
                    pathType.NavigatingView()
                }
            }
            
        }
        .environment(navigationManager)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                navigationManager.push(to: .plan)
            }
        }
    }
}

#Preview {
    ContentView()
}
