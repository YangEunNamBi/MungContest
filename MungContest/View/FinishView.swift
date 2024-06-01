//
//  FinishView.swift
//  MungContest
//
//  Created by Woowon Kang on 6/1/24.
//

import SwiftUI

struct FinishView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        Text("대회 종료 화면")
    }
}

#Preview {
    FinishView()
        .environment(NavigationManager())
}
