//
//  PlanView.swift
//  MungContest
//
//  Created by Woowon Kang on 6/1/24.
//

import SwiftUI

struct PlanView: View {
    @Environment(NavigationManager.self) var navigationManager
    @State private var name: String = UserDefaults.standard.contestTitle
    
    var body: some View {
        VStack {
            TextField("대회 제목을 입력해주세요", text: $name)
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
