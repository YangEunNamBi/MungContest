//
//  RankCustomTextStyle.swift
//  MungContest
//
//  Created by 이상도 on 8/17/24.
//

import SwiftUI

/// RankListView Text 속성 뷰 모디파이어
struct RankCustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12))
            .foregroundColor(.white.opacity(0.6))
    }
}

extension Text {
    func customStyle() -> some View {
        self.modifier(RankCustomTextStyle())
    }
}
