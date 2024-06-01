//
//  PlanView.swift
//  MungContest
//
//  Created by Woowon Kang on 6/1/24.
//

import SwiftUI

struct PlanView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        VStack {
            Button("대기 화면으로") {
                navigationManager.push(to: .standby)
            }
        }
    }
}

#Preview {
    PlanView()
        .environment(NavigationManager())
}
