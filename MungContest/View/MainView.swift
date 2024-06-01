//
//  MainView.swift
//  MungContest
//
//  Created by Woowon Kang on 6/1/24.
//

import SwiftUI

struct MainView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        VStack {
            Button("대회 설정 화면으로") {
                navigationManager.push(to: .finish)
            }
        }
    }
}

#Preview {
    MainView()
        .environment(NavigationManager())
}
