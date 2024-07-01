
import SwiftUI

struct MainView: View {
    
    @Environment(NavigationManager.self) var navigationManager
    
  @AppStorage("contestTitle") private var contestTitle: String = UserDefaults.standard.contestTitle
//    @State private var contestTitle: String = ""
    
    // MainView 세그먼트 컨트롤
    @State private var selectedSegment = 0
    private let segments = ["chart.bar.fill", "tablecells.badge.ellipsis"]
    
    @State private var hour: Int = 0 // UserDefaults의 시간을 받을 변수
    @State private var minute: Int = 0 // UserDefaults의 분을 받을 변수
    @State private var totalSeconds: Int = 0 // hour&minute를 초로환산해서 담을 변수
    
    // MARK: 프로그레스 바 ( 타이머 )
    @State private var time: Double = 0
    @State private var initialTime: Double = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // 1초마다
    
    var body: some View {
        VStack{
            HStack{
                Text("mung contest")
                    .fontWeight(.bold)
                    .font(Font.custom("Poppins-Regular", size: 28))
                    .foregroundColor(Color.accentColor)
                
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
                Text("\(contestTitle)")
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
                            // print("게임종료")
                            // 0초일 경우 게임 종료
                        }
                    }
                
                HStack{
                    Image(systemName: "timer")
                    
                    Text("- \(formatTime(seconds: Int(time)))") // 남은시간 Text
                        .font(.system(size: 14))
                        .bold()
                        .frame(width: 80)
                }
                .padding(.leading)
            }
            
            HStack(spacing: 20){
                if selectedSegment == 0 {
                    RankView() // 상위/하위 3명 랭킹 뷰
                    RankListView() // 전체 인원 랭킹 리스트 뷰
                } else {
                    RecordView() // 심박 수 측정 뷰
                }
            }
            .padding(.top)
        }
        .padding(.horizontal, 50)
        //        .padding(.top, 50) // Navigation영역이랑과의 Padding 값
        .onAppear {
            // UserDefaults에서 대회 시간받아서 초로 환산
            loadSavedTime()
            calculateTotalSeconds()
            time = Double(totalSeconds)
            initialTime = time
//            loadContestTitle()
        }
    }
    
    // MARK: contestTitle - UserDefaults
//    private func loadContestTitle() {
//        contestTitle = UserDefaults.standard.string(forKey: "contestTitle") ?? "대회이름"
//    }
//    
    // MARK: UserDefaults에서 시간과 분 불러오기
    private func loadSavedTime() {
        hour = UserDefaults.standard.integer(forKey: "selectedHours")
        minute = UserDefaults.standard.integer(forKey: "selectedMinutes")
    }
    
    // MARK: 프로그레스바 Value : UserDefaults의 시간&분 -> 초로 환산
    private func calculateTotalSeconds() {
        totalSeconds = hour * 60 * 60 + minute * 60
    }
    
    // MARK: 대회 남은 시간 Text - 시간:분:초로 변형
    private func formatTime(seconds: Int) -> String {
        if seconds >= 3600 {
            let hours = seconds / 3600
            let minutes = (seconds % 3600) / 60
            let remainingSeconds = seconds % 60
            return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
        } else {
            let minutes = seconds / 60
            let remainingSeconds = seconds % 60
            return String(format: "%02d:%02d", minutes, remainingSeconds)
        }
    }
}

// MARK: ProgressBar
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
