import SwiftUI
import SwiftData
import Combine

struct MainView: View {
    
    @Environment(NavigationManager.self) var navigationManager
    
    @AppStorage("contestTitle") private var contestTitle: String = UserDefaults.standard.contestTitle
    
    // MainView 세그먼트 컨트롤
    @State private var selectedSegment = 0
    private let segments = ["chart.bar.fill", "tablecells.badge.ellipsis"]
    
    @State private var hour: Int = 0 // UserDefaults의 시간을 받을 변수
    @State private var minute: Int = 0 // UserDefaults의 분을 받을 변수
    @State private var totalSeconds: Int = 0 // hour&minute를 초로환산해서 담을 변수
    
    // MARK: 프로그레스 바 ( 타이머 )
    @State private var time: Double = 0
    @State private var initialTime: Double = 0
    @State private var timer: AnyCancellable? // 타이머를 관리할 변수
    
    @Query var players: [Player]
    
    // 랜덤여부에 따른 측정 Alert
    @State private var showingAlert = false
    @State private var randomValue = false /// 랜덤여부 Bool
    @State private var measureCount = 0 // 측정횟수
    @State private var measureIntervals: [Int] = [] // 알림을 띄울 시간 목록
    @State private var alertIndex = 0 // 현재 띄워진 알림의 인덱스
    
    var body: some View {
        VStack{
            HStack{
                Text("mung contest")
                    .font(Font.custom("Poppins-Bold", size: 28))
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
                    if allHeartratesEmpty() { // 표준편차가 아직 없다면 Lock 이미지
                        Image("lock")
                            .resizable()
                            .frame(width: .infinity, height: .infinity)
                    } else { // 표준편차가 있다면 랭킹 보여주기
                        RankView() // 상위&하위 3명 랭킹 뷰
                        RankListView() // 전체 인원 랭킹 리스트 뷰
                    }
                } else {
                    RecordView() // 심박 수 측정 뷰
                }
            }
            .padding(.top)
        }
        .padding(.horizontal, 50)
        .onAppear {
            // UserDefaults에서 대회 시간받아서 초로 환산
            loadSavedTime()
            calculateTotalSeconds()
            time = Double(totalSeconds)
            initialTime = time
            
            randomValue = UserDefaults.standard.bool(forKey: "isRandom")
            if randomValue {
                setRandomMeasure()
            } else {
                setNotRandomMeasure()
            }
            //            setNotRandomMeasure()
            startTimer() // 타이머 시작
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("알림"), message: Text("측정시간이 되었습니다."), dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK: Lock 이미지 on/off 여부 ( 모든 resultHeartrate가 비어있는지 확인하는 함수 )
    private func allHeartratesEmpty() -> Bool {
        players.allSatisfy { $0.resultHeartrate == 0 }
    }
    
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
    
    // MARK: 심박수 측정 주기 랜덤아닐때
    private func setNotRandomMeasure() {
        print(#function)
        print("측정주기는 랜덤이 아닙니다.")
        measureCount = UserDefaults.standard.integer(forKey: "measurementCount")
        
        // 측정 시간 간격 계산
        if measureCount > 1 {
            let interval = totalSeconds / (measureCount - 1)
            measureIntervals = (1..<measureCount).map { totalSeconds - $0 * interval }
        }
        print("Alert가 등장할 시간(s): \(measureIntervals)")
    }
    
    // MARK: 심박수 측정 주기 랜덤일 때
    private func setRandomMeasure() {
        print(#function)
        print("측정주기는 랜덤입니다.")
        measureCount = UserDefaults.standard.integer(forKey: "measurementCount")
        
        if measureCount > 1 {
            let interval = totalSeconds / (measureCount - 1)
            measureIntervals = (1..<measureCount).map { index in
                if index == 0 || index == measureCount - 1 {
                    return totalSeconds - index * interval // 첫 번째와 마지막은 정확히 일정한 시간
                } else {
                    // 중간 시점들은 ±60초 범위에서 랜덤 오프셋 적용
                    let baseTime = totalSeconds - index * interval
                    let randomOffset = Int.random(in: -5...5)
                    return baseTime + randomOffset
                }
            }
        }
        print("Alert가 등장할 시간(s): \(measureIntervals)")
    }
    
    // MARK: 타이머 시작
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if time > 0 {
                    time -= 1
                    print("현재 남은 시간: \(Int(time))초")
                    
                    // 현재 시간이 다음 알림 시간과 일치하는지 확인
                    if alertIndex < measureIntervals.count && Int(time) == measureIntervals[alertIndex] {
                        showingAlert = true
                        alertIndex += 1 // 다음 알림을 준비
                    }
                } else { // 게임종료시
                    showingAlert = true
                    stopTimer() // 타이머 중지
                }
            }
    }
    
    // MARK: 타이머 중지
    private func stopTimer() {
        timer?.cancel()
        timer = nil
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
