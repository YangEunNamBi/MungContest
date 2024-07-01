
import SwiftUI
import SwiftData

struct RankListView: View {
    
    let columns = [GridItem(.flexible())]
    
    @State private var currentStartIndex = 0
    private let interval: TimeInterval = 5.0 // List 체인지 되는 시간(초)
    
    @State private var currentRanks: [UUID: Int] = [:] // Player들의 현재 순위 배열
    @State private var previousRanks: [UUID: Int] = [:] // Player들의 이전 순위 배열
    
    @Query var players: [Player]
    var sortedPlayers: [Player] {
        players.sorted { $0.resultHeartrate < $1.resultHeartrate }
    }
    
    var body: some View {
        VStack{
            VStack{
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
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(Array(sortedPlayers[currentStartIndex..<min(currentStartIndex + 6, sortedPlayers.count)]), id: \.id) { player in
                        GridCellView(rank: sortedPlayers.firstIndex(where: { $0.id == player.id })! + 1, player: player, previousRank: previousRanks[player.id] ?? 0)
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(30)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
                if currentStartIndex + 6 >= players.count {
                    currentStartIndex = 0
                } else {
                    currentStartIndex += 6
                }
            }
        }
    }
}

struct GridCellView: View {
    
    let rank: Int // 순위 표기
    let player: Player // 데이터
    
    let previousRank: Int // 이전순위 (순위변동)
    
    var body: some View {
        HStack {
            Text("\(rank)") // 순위 1위부터
                .font(.system(size: 20))
                .frame(width: 30, alignment: .center)
                .bold()
                .padding()
            changeRank()
                .padding()
            
            playerName()
                .padding()
            
            playerBpm()
            
            totalDeviation()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 87)
        .background(Color.mcGray800)
        .cornerRadius(20)
    }
    
    // 순위변동
    func changeRank() -> some View {
        let rankChange = rank - previousRank
        return HStack{
            if rankChange > 0 { // 순위가 상승했다면
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.mcBlue)
                Text("\(rankChange)")
                    .font(.system(size: 12))
            } else if rankChange < 0 { // 순위가 하락했다면
                Image(systemName: "arrowtriangle.up.fill")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.red)
                Text("\(abs(rankChange))")
                    .font(.system(size: 12))
            } else { // 순위가 동일하다면
                Text("-")
                    .font(.system(size: 12))
            }
        }
    }
    
    // 유저 이름
    func playerName() -> some View {
        VStack{
            HStack {
                Text(player.name)
                    .font(Font.custom("SpoqaHanSansNeo-Bold", size: 20))
                    .frame(width: 110, alignment: .center)
            }
        }
    }
    
    // 현재 심박수
    func playerBpm() -> some View {
        ZStack {
            Capsule()
                .frame(width: 114, height: 40)
                .foregroundColor(.black)
            
            HStack {
                Text("\(player.heartrates.filter { $0 != 0 }.last ?? 0)")
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(Color.accentColor)
                
                Text("bpm")
                    .font(.system(size: 14))
            }
        }
    }
    
    // 편차 합계
    func totalDeviation() -> some View {
        return ZStack {
            Capsule()
                .frame(width: 70, height: 40)
                .foregroundColor(.black)
            
            HStack {
                Text("\(player.resultHeartrate)")
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 20))
                    .bold()
            }
        }
    }
}

// MARK: Text 속성 - 뷰 모디파이어
struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12))
            .foregroundColor(.white.opacity(0.6))
    }
}
extension Text {
    func customStyle() -> some View {
        self.modifier(CustomTextStyle())
    }
}

struct RankListView_Previews: PreviewProvider {
    static var previews: some View {
        RankListView()
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}
