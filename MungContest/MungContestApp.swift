//
//  MungContestApp.swift
//  MungContest
//
//  Created by Hyun Jaeyeon on 6/1/24.
//

import SwiftUI
import SwiftData

@main
struct MungContestApp: App {
    
    var modelContainer: ModelContainer = {
        let schema = Schema([Player.self])
        let modelConfiguration = ModelConfiguration(schema: schema,
                                                    isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema,
                                      configurations: [modelConfiguration])
        } catch {
            fatalError("modelContainer가 생성되지 않았습니다: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
