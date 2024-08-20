//
//  TimerProgressBar.swift
//  MungContest
//
//  Created by 이상도 on 8/17/24.
//

import SwiftUI

struct TimerProgressBar: View {
    
    var time: Double
    var initialTime: Double
    
    var body: some View {
        HStack {
            ProgressView(value: time, total: initialTime)
                .progressViewStyle(LinearProgressViewStyle())
                .scaleEffect(CGSize(width: 1.0, height: 3.0))
                .tint(Color.accentColor)
        }
    }
}
