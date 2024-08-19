import Combine
import SwiftUI

class MeasureTimer: ObservableObject {
    
    @Published var time: Double
    @Published var initialTime: Double
    @Published var activeAlert: MeasureAlertType?
    
    private var timer: AnyCancellable?
    private var measureIntervals: [Int] = [] // 알림을 띄울 시간 목록
    private var alertIndex = 0 // 현재 띄워진 알림의 index
    
    init(initialTime: Double) {
        self.initialTime = initialTime
        self.time = initialTime
        self._activeAlert = Published(initialValue: nil)
    }
    
    /// 타이머 시작
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTime()
            }
    }
    
    /// 타이머 종료
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    /// 타이머 업데이트
    private func updateTime() {
        if time > 0 {
            time -= 1
            print("현재 남은 시간: \(Int(time))초")
            
            if alertIndex < measureIntervals.count && Int(time) == measureIntervals[alertIndex] {
                activeAlert = .measurement
                alertIndex += 1
            }
        }
        
        if time <= 0 {
            activeAlert = .finish
            stopTimer()
            print("대회시간 종료")
        }
    }
    
    /// 측정주기 -> 랜덤아닐때
    func setNotRandomMeasure(measureCount: Int, totalSeconds: Int) {
        print(#function)
        print("랜덤여부 : \(UserDefaults.standard.bool(forKey: "isRandom"))")
        
        let adjustedMeasureCount = measureCount
        
        if adjustedMeasureCount > 0 {
            let interval = totalSeconds / adjustedMeasureCount
            measureIntervals = (1...adjustedMeasureCount).map { totalSeconds - $0 * interval }
        }
        
        print("측정 알림 시간(초) : \(measureIntervals)")
    }
    
    /// 측정주기 -> 랜덤일때
    func setRandomMeasure(measureCount: Int, totalSeconds: Int) {
        print(#function)
        print("랜덤여부 : \(UserDefaults.standard.bool(forKey: "isRandom"))")
        
        let adjustedMeasureCount = measureCount
        
        if adjustedMeasureCount > 0 {
            let interval = totalSeconds / adjustedMeasureCount
            var intervals = (1...adjustedMeasureCount).map { index in
                if index == 0 || index == adjustedMeasureCount - 1 {
                    return totalSeconds - index * interval
                } else {
                    let baseTime = totalSeconds - index * interval
                    let randomOffset = Int.random(in: -5...5) // +-랜덤 범위 (초 단위)
                    return baseTime + randomOffset
                }
            }
            // 마지막 값을 정확히 0으로 설정
            intervals[adjustedMeasureCount - 1] = 0
            
            measureIntervals = intervals
        }
        print("측정 알림 시간(초) : \(measureIntervals)")
    }

}
