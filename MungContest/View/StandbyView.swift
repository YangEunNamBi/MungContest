//
//  StandbyView.swift
//  MungContest
//
//  Created by Woowon Kang on 6/1/24.
//

import SwiftUI

struct StandbyView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        VStack {
            Button("대회 메인 화면으로") {
                navigationManager.push(to: .main)
            }
        }
    }
}

#Preview {
    StandbyView()
        .environment(NavigationManager())
}
