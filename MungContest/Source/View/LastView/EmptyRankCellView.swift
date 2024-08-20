//
//  EmptyRankCellView.swift
//  MungContest
//
//  Created by 이상도 on 8/19/24.
//

import SwiftUI

struct EmptyRankCellView: View {
    var body: some View {
        // 빈 셀에 대한 레이아웃을 만들어 주는 부분
        HStack {
            Text(" ") // 텍스트를 사용하여 빈 공간을 차지하도록 설정
                .font(.system(size: 20, weight: .bold))
                .frame(width: 30, alignment: .center)
                .padding(.leading, 45)
            
            Spacer()
            
            Text(" ")
                .frame(width: 110, alignment: .center)
            
            Spacer()
            
            ZStack {
                Capsule()
                    .frame(width: 114, height: 40)
                    .foregroundColor(.clear)
            }
            
            Spacer()
            
            ZStack {
                Capsule()
                    .frame(width: 70, height: 40)
                    .foregroundColor(.clear)
            }
            .padding(.trailing, 45)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 87)
        .background(Color.clear)
        .cornerRadius(20)
    }
}


#Preview {
    EmptyRankCellView()
}
