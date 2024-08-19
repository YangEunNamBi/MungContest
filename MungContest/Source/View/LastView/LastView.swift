import SwiftUI
import SwiftData

struct LastView: View {
    
    @Environment(NavigationManager.self) var navigationManager
    
    @AppStorage("contestTitle") private var contestTitle: String = UserDefaults.standard.contestTitle
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var nowStartIndex = 0
    private let interval: TimeInterval = 5.0 // 리스트가 변경되는 시간(초)
    
    @StateObject private var viewModel = RankViewModel()
    
    @Query var players: [Player]
    var sortedPlayers: [Player] {
        players.sorted { $0.resultHeartrate < $1.resultHeartrate }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 헤더 부분 (고정)
            VStack(spacing: 10) {
                HStack {
                    Text("mung contest")
                        .font(Font.custom("Poppins-Bold", size: 28))
                        .foregroundColor(Color.accentColor)
                        .padding(.leading)
                    
                    Spacer()
                }
                
                VStack(alignment: .center, spacing: 10) {
                    Text(contestTitle)
                        .font(Font.custom("SpoqaHanSansNeo-Medium", size: 16))
                        .foregroundColor(.mcGray300)
                    
                    Text("최종 순위를 확인해보세요!")
                        .font(Font.custom("SpoqaHanSansNeo-Bold", size: 28))
                        .foregroundColor(.white)
                }
                .padding()
            }
            
            // 그리드 및 리스트 부분
            VStack {
                LazyVGrid(columns: columns, spacing: 15) {
                    // 그리드 안의 각 열
                    ForEach(0..<2, id: \.self) { column in
                        VStack {
                            HStack {
                                Text("순위")
                                    .customStyle()
                                    .padding(.leading, 45)
                                Spacer()
                                Text("이름")
                                    .customStyle()
                                Spacer()
                                Text("평균 심박수")
                                    .customStyle()
                                Spacer()
                                Text("편차 평균")
                                    .customStyle()
                                    .padding(.trailing, 55)
                            }
                            .frame(maxWidth: .infinity)
                            
                            // 플레이어 리스트
                            LazyVStack(spacing: 15) {
                                let start = nowStartIndex + column * 6
                                let end = min(nowStartIndex + (column + 1) * 6, sortedPlayers.count)
                                let numberOfPlayersInColumn = end - start
                                
                                if start < end { // 유효한 범위인지 확인
                                    ForEach(Array(sortedPlayers[start..<end]), id: \.id) { player in
                                        LastRankCellView(rank: sortedPlayers.firstIndex(where: { $0.id == player.id })! + 1, player: player)
                                    }
                                }
                                
                                // 빈 셀 채우기
                                ForEach(0..<(6 - numberOfPlayersInColumn), id: \.self) { _ in
                                    EmptyRankCellView() // 빈 셀을 넣어서 공간 유지
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .top)
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(30)
            .onAppear {
                startTimer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(30)
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            let totalPlayers = sortedPlayers.count
            let numberOfPlayersToShow = 12
            
            nowStartIndex += numberOfPlayersToShow
            
            if nowStartIndex >= totalPlayers {
                nowStartIndex = 0
            }
        }
    }
}

struct LastRankCellView: View {
    
    let rank: Int // 순위 표기
    let player: Player // 데이터
    
    var body: some View {
        HStack {
            Text("\(rank)") // 순위 1위부터
                .font(.system(size: 20, weight: .bold))
                .frame(width: 30, alignment: .center)
                .padding(.leading, 45)
            
            Spacer()
            
            playerName()
            
            Spacer()
            
            playerBpm()
            
            Spacer()
            
            totalDeviation()
                .padding(.trailing, 45)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 87)
        .background(Color.mcGray800)
        .cornerRadius(20)
    }
    
    /// 유저 이름
    func playerName() -> some View {
        VStack {
            HStack {
                Text(player.name)
                    .font(Font.custom("SpoqaHanSansNeo-Bold", size: 20))
                    .frame(width: 110, alignment: .center)
            }
        }
    }
    
    /// 평균 심박수
    func playerBpm() -> some View {
        ZStack {
            Capsule()
                .frame(width: 114, height: 40)
                .foregroundColor(.black)
            
            HStack {
                Text("\(player.heartrates.reduce(0, +) / player.heartrates.count)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.accentColor)
                
                Text("bpm")
                    .font(.system(size: 14))
            }
        }
    }
    
    // 편차 평균
    func totalDeviation() -> some View {
        return ZStack {
            Capsule()
                .frame(width: 70, height: 40)
                .foregroundColor(.black)
            
            HStack {
                Text("\(player.resultHeartrate / player.heartrates.count)")
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 20, weight: .bold))
            }
        }
    }
}

#Preview {
    LastView()
        .previewInterfaceOrientation(.landscapeLeft)
        .preferredColorScheme(.dark)
        .environment(NavigationManager())
}
