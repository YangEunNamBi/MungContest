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
    
    // 프로그레스 바 타이머
    @State private var time: Double = 100 // 임시 값
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // every 1: 1초마다
    
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    @State private var totalSeconds: Int = 0 // 이걸 나중에 time변수로 넣어야함
    
    var body: some View {
        VStack{
            HStack{
                Text("MUNG-CON")
                    .font(.system(size: 28))
                    .foregroundColor(Color(UIColor(hex: "#FFF7AB")))
                    .bold()
                
                Spacer()
                
                HStack{
                    Picker("SegmentControl", selection: $selectedSegment) {
                        ForEach(0..<segments.count) { index in
                            Image(systemName: self.segments[index]).tag(index)
                            
                        }
                    }
                    .colorMultiply(Color(UIColor(hex: "#FFF7AB")))
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
                CustomProgressView(time: time)
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
    
    // 프로그레스바 Value : 세팅에서 시간과 분을 바인딩으로 받아서 초로 환산
    private func calculateTotalSeconds() {
           totalSeconds = hour * 60 * 60 + minute * 60
    }
    
    // 남은 시간 Text : 분&초로만 변형
    private func formatTime(minute: Int, second: Int) -> String {
        return String(format: "%02d:%02d", minute, second)
    }
}

// ProgressBar
struct CustomProgressView: View {
    
    var time: Double
    
    var body: some View {
        HStack {
            ProgressView(value: time, total: 100) // total도 totalSeconds로 변경하기
                .progressViewStyle(LinearProgressViewStyle())
                .scaleEffect(CGSize(width: 1.0, height: 3.0))
                .tint(Color(UIColor(hex: "#FFF7AB")))
        }
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hexString).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexString.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8 * 1 & 0xF) * 17, (int >> 8 * 0 & 0xF) * 17, (int >> 8 * 2 & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24 & 0xFF, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
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
