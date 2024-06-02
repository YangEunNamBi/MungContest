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
    @State private var measurementCount: Int = UserDefaults.standard.integer(forKey: "measurementCount")
    @State private var isRandom: Bool = UserDefaults.standard.bool(forKey: "isRandom")
    
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
                    .padding(.horizontal, 20)
                    
                    VStack {
                        Text("측정 횟수")
                        Button {
                            incrementCount()
                        } label: {
                            Image(systemName: "chevron.up")
                        }
                        
                        Text("\(measurementCount)")
                        
                        Button {
                            decrementCount()
                        } label: {
                            Image(systemName: "chevron.down")
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    
                    VStack {
                        Text("랜덤 여부")
                        HStack {
                            Button {
                                setCircle()
                            } label: {
                                Image(systemName: "chevron.left")
                            }
                            .opacity(isRandom ? 1 : 0)
                            Image(systemName: isRandom ? "xmark" : "circle")
                            Button {
                                setXmark()
                            } label: {
                                Image(systemName: "chevron.right")
                            }
                            .opacity(isRandom ? 0 : 1)
                        }
                    }
                    .padding(.horizontal, 20)
                    .background()
                }
                
            }
            .padding(.horizontal, 10)
            
            VStack(alignment: .leading) {
                Text("참가자 파일 불러오기")
                HStack {
                    Text("구글 폼 불러오기")
                    Text("참가자 이미지 불러오기")
                }
            }
            
            // 다음으로 버튼
            Button("대기 화면으로") {
                navigationManager.push(to: .standby)
            }
        }
    }
    
    //MARK: - 측정 횟수 함수
    private func incrementCount() {
        if measurementCount < 5 {
            measurementCount += 1
            saveCount()
        }
    }
    
    private func decrementCount() {
        if measurementCount > 1 {
            measurementCount -= 1
            saveCount()
        }
    }
    
    private func saveCount() {
        UserDefaults.standard.set(measurementCount, forKey: "measurementCount")
    }
    
    //MARK: - 랜덤 여부 함수
    private func setCircle() {
        isRandom = false
        saveState()
    }
    
    private func setXmark() {
        isRandom = true
        saveState()
    }
    
    private func saveState() {
        UserDefaults.standard.set(isRandom, forKey: "isRandom")
    }
}

#Preview {
    PlanView()
        .environment(NavigationManager())
}
