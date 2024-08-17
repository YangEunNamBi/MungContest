import SwiftUI
import SwiftData
import Combine

struct MainView: View {
    
    @Environment(NavigationManager.self) var navigationManager
    
    @Query var players: [Player]
    @AppStorage("contestTitle") private var contestTitle: String = UserDefaults.standard.contestTitle
    
    /// MainView 세그먼트 컨트롤
    @State private var selectedSegment = 1
    @State private var segments = ["chart.bar.fill", "tablecells.badge.ellipsis"]
    
    @State private var hour: Int = 0 // UserDefaults의 시간을 받을 변수
    @State private var minute: Int = 0 // UserDefaults의 분을 받을 변수
    @State private var totalSeconds: Int = 0 // hour&minute를 초로환산해서 담을 변수
    
    @State private var randomValue: Bool = false
    @StateObject private var timerService: MeasureTimer
    
    init() {
        _timerService = StateObject(wrappedValue: MeasureTimer(initialTime: 0))
    }
    
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
                Text("\(UserDefaults.standard.contestTitle)")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
            }
            
            HStack{
                TimerProgressBar(time: timerService.time, initialTime: Double(totalSeconds))
                
                HStack{
                    Image(systemName: "timer")
                    
                    Text("- \((Int(timerService.time)).formatTime())")
                        .font(.system(size: 14, weight: .bold))
                        .frame(width: 80)
                }
                .padding(.leading)
            }
            
            HStack(spacing: 20){
                if selectedSegment == 0 {
                    if allHeartratesEmpty() { // 표준편차가 없다면
                        Image("lock")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else { // 표준편차가 있다면
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
            loadSavedTime()
            calculateTotalSeconds()
            timerService.time = Double(totalSeconds)
            randomValue = UserDefaults.standard.bool(forKey: "isRandom")
            if randomValue {
                timerService.setRandomMeasure(measureCount: UserDefaults.standard.integer(forKey: "measurementCount"), totalSeconds: totalSeconds)
            } else {
                timerService.setNotRandomMeasure(measureCount: UserDefaults.standard.integer(forKey: "measurementCount"), totalSeconds: totalSeconds)
            }
            timerService.startTimer()
        }
        .alert(item: $timerService.activeAlert) { alertType in
            MeasureAlertType.alert(for: alertType)
        }
    }
    
    /// Lock 이미지 on/off 여부 ( 모든 resultHeartrate가 비어있는지 확인하는 함수 )
    private func allHeartratesEmpty() -> Bool {
        players.allSatisfy { $0.resultHeartrate == 0 }
    }
    
    /// UserDefaults에서 시간과 분 불러오기
    private func loadSavedTime() {
        hour = UserDefaults.standard.integer(forKey: "selectedHours")
        minute = UserDefaults.standard.integer(forKey: "selectedMinutes")
    }
    
    /// 프로그레스바 Value : UserDefaults의 시간&분 -> 초로 환산
    private func calculateTotalSeconds() {
        totalSeconds = hour * 60 * 60 + minute * 60
    }
    
}

extension Int {
    /// 대회 남은 시간 Text - 시간:분:초로 변형
    func formatTime() -> String {
        if self >= 3600 {
            let hours = self / 3600
            let minutes = (self % 3600) / 60
            let remainingSeconds = self % 60
            return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
        } else {
            let minutes = self / 60
            let remainingSeconds = self % 60
            return String(format: "%02d:%02d", minutes, remainingSeconds)
        }
    }
}
