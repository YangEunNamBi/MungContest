//
//  Measure.swift
//  MungContest
//
//  Created by 이상도 on 8/17/24.
//

import SwiftUI

enum MeasureAlertType: Identifiable {
    
    case measurement
    case finish
    
    var id: Int {
        switch self {
        case .measurement:
            return 1
        case .finish:
            return 2
        }
    }
}

extension MeasureAlertType {
    static func alert(for type: MeasureAlertType) -> Alert {
        switch type {
        case .measurement:
            return Alert(
                title: Text("알림"),
                message: Text("측정시간이 되었습니다."),
                dismissButton: .default(Text("확인"))
            )
        case .finish:
            return Alert(
                title: Text("알림"),
                message: Text("게임시간이 종료되었습니다.\n마지막 심박수 측정을 해주세요."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}

