//
//  MainView.swift
//  MungContest
//
//  Created by Woowon Kang on 6/1/24.
//

import SwiftUI

struct MainView: View {
    
    @Environment(NavigationManager.self) var navigationManager
    
    // MainView 세그먼트 컨트롤
    @State private var selectedSegment = 0
    private let segments = ["chart.bar.fill", "tablecells.badge.ellipsis"]
    
    // MARK: 프로그레스 바 ( 타이머 )
    @State private var time: Double = 100 // 전체 게임 시간
    @State private var initialTime: Double = 100 // 초기 값 저장( time이랑 같은 값이어야함 )
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // every 1 = 1초마다
    
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    @State private var totalSeconds: Int = 0 // 이걸 나중에 time변수로 넣어야함
    
    var body: some View {
        VStack{
            HStack{
                Text("MUNG-CON")
                    .font(.system(size: 28))
                    .foregroundColor(Color.accentColor)
                    .bold()
                
                Spacer()
                
                HStack{
                    Picker("SegmentControl", selection: $selectedSegment) {
                        ForEach(0..<segments.count) { index in
                            Image(systemName: self.segments[index]).tag(index)
                            
                        }
                    }
                    .colorMultiply(Color.accentColor)
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(height: 50)
                }
                .frame(width: 200)
            }
            
            HStack{
                Text("원의 멍때리기 대회 ") // 나중에 제목 바인딩으로 받음
                    .font(.system(size: 28))
                    .bold()
                Spacer()
                
            }
            
            HStack{
                CustomProgressView(time: time, initialTime: initialTime)
                    .onReceive(timer) { _ in
                        if time > 0 { // 설정한 시간이 0초 이상 남았을경우 감소
                            time -= 1
                        } else {
                            
                            // 0초일 경우 게임 종료
                            
                        }
                    }
                
                HStack{
                    Image(systemName: "timer")
                    Text("-29:30")
                        .font(.system(size: 14))
                        .bold()
                }
                .padding(.leading)
            }
            
            HStack(spacing: 20){
                if selectedSegment == 0 {
                     RankView()
                     RankListView()
                } else {
                    // RecordView()
                    
                }
            }
            .padding(.top)
           
        }
        .padding(.horizontal, 50)
        .padding(.top, 50)
    }
    
    // MARK: 프로그레스바 Value : UserDefaults의 시간&분 -> 초로 환산
    private func calculateTotalSeconds() {
           totalSeconds = hour * 60 * 60 + minute * 60
    }
    
    // MARK: 남은 시간 Text - 분&초로만 변형
    private func formatTime(minute: Int, second: Int) -> String {
        return String(format: "%02d:%02d", minute, second)
    }
}

// ProgressBar
struct CustomProgressView: View {
    
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(NavigationManager())
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}
