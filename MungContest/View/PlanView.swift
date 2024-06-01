//
//  PlanView.swift
//  MungContest
//
//  Created by Woowon Kang on 6/1/24.
//

import SwiftUI

struct PlanView: View {
    @Environment(NavigationManager.self) var navigationManager
    @State private var title: String = UserDefaults.standard.contestTitle
    
    var body: some View {
        VStack {
            TextField("대회 제목을 입력해주세요", text: $title)
                .font(.system(size: 28))
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 50)
            
            HStack {
                Group {
                    VStack {
                        Text("대회 시간")
                    }
                    VStack {
                        Text("측정 횟수")
                        Image(systemName: "chevron.up")
                        Text("1")
                        Image(systemName: "chevron.down")
                        
                    }
                    VStack {
                        Text("랜덤 여부")
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("1")
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                
            }
            
            VStack(alignment: .leading) {
                Text("참가자 파일 불러오기")
                HStack {
                    Text("참가자 사진 불러오기")
                    Text("참가자 명단 불러오기")
                }
            }
            
            // 다음으로 버튼
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
