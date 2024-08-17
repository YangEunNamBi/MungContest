import SwiftUI
import SwiftData

struct LastView: View {
    
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
            
            VStack {
                LazyVGrid(columns: columns, spacing: 15) {
                    // 첫 번째 열의 헤더
                    VStack {
                        HStack {
                            Text("순위")
                                .customStyle()
                                .padding(.leading, 45)
                            
                            Text("순위 변동")
                                .customStyle()
                                .padding(.leading, 25)
                            
                            Text("이름")
                                .customStyle()
                                .padding(.leading, 60)
                            
                            Text("현재 심박수")
                                .customStyle()
                                .padding(.leading, 90)
                            
                            Text("편차 합계")
                                .customStyle()
                                .padding(.leading, 45)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    // 두 번째 열의 헤더
                    VStack {
                        HStack {
                            Text("순위")
                                .customStyle()
                                .padding(.leading, 45)
                            
                            Text("순위 변동")
                                .customStyle()
                                .padding(.leading, 25)
                            
                            Text("이름")
                                .customStyle()
                                .padding(.leading, 60)
                            
                            Text("현재 심박수")
                                .customStyle()
                                .padding(.leading, 90)
                            
                            Text("편차 합계")
                                .customStyle()
                                .padding(.leading, 45)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    // 플레이어 리스트
                    ForEach(Array(sortedPlayers[nowStartIndex..<min(nowStartIndex + 12, sortedPlayers.count)]), id: \.id) { player in
                        RankListCellView(rank: sortedPlayers.firstIndex(where: { $0.id == player.id })! + 1, player: player, previousRank: viewModel.previousRanks[player.id] ?? 0, currentRank: viewModel.currentRanks[player.id] ?? 0)
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .padding(.horizontal, 20)
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

#Preview {
    LastView()
        .previewInterfaceOrientation(.landscapeLeft)
        .preferredColorScheme(.dark)
}
