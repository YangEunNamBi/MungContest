
import SwiftUI
import SwiftData

struct RankListView: View {
    
    
    let columns = [GridItem(.flexible())]
    
    var players: [Player] = []
    
    init() {
        players = createDummyPlayers().sorted { $0.resultHeartrate < $1.resultHeartrate }
    }
    
    
    var body: some View {
        VStack{
            VStack{
                HStack {
                    Spacer()
                    HStack(alignment: .center){
                        Text("순위")
                            .customStyle()
                    }
                    
                    Spacer()
                    HStack(alignment: .center){
                        Text("순위 변동")
                            .customStyle()
                    }
                    
                    Spacer()
                    HStack(alignment: .center){
                        Text("이름")
                            .customStyle()
                        
                    }
                    
                    Spacer()
                    HStack(alignment: .center){
                        Text("현재 심박수")
                            .customStyle()
                        
                    }
                    .padding(.horizontal, 45)
                    Spacer()
                    
                    HStack(alignment: .center){
                        Text("편차 합계")
                            .customStyle()
                    }
                    .padding(.leading, 10)
                    Spacer()
                    
                }
                .padding(.trailing, 20)
                .padding(.bottom)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(Array(players.prefix(6).enumerated()), id: \.offset) { index, player in
                        GridCellView(rank: index + 1, player: player)
                        //                            .frame(maxHeight: .infinity) // 각 셀의 높이를 동적으로 조정
                        //                            .aspectRatio(contentMode: .fit)
                    }
                }
                .frame(maxHeight: .infinity)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(30)
    }
    
    // 임시 데이터
    func createDummyPlayers() -> [Player] {
        func calculateDifferenceHeartrates(defaultHeartrate: Int, heartrates: [Int]) -> [Int] {
            return heartrates.map { abs(defaultHeartrate - $0) }
        }
        
        let player1 = Player(
            name: "Player 1",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 1",
            defaultHeartrate: 70,
            heartrates: [70, 75, 73, 72],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 70, heartrates: [70, 75, 73, 72]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 70, heartrates: [70, 75, 73, 72]).reduce(0, +)
        )
        
        let player2 = Player(
            name: "Player 2",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 2",
            defaultHeartrate: 115,
            heartrates: [65, 68, 66, 67],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 115, heartrates: [65, 68, 66, 67]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 115, heartrates: [65, 68, 66, 67]).reduce(0, +)
        )
        
        let player3 = Player(
            name: "Player 3",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 3",
            defaultHeartrate: 80,
            heartrates: [80, 82, 81, 79],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 80, heartrates: [80, 82, 81, 79]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 80, heartrates: [80, 82, 81, 79]).reduce(0, +)
        )
        
        let player4 = Player(
            name: "Player 4",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 4",
            defaultHeartrate: 75,
            heartrates: [75, 77, 76, 78],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 75, heartrates: [75, 77, 76, 78]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 75, heartrates: [75, 77, 76, 78]).reduce(0, +)
        )
        
        let player5 = Player(
            name: "Player 5",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 5",
            defaultHeartrate: 110,
            heartrates: [60, 62, 61, 63],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 110, heartrates: [60, 62, 61, 63]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 110, heartrates: [60, 62, 61, 63]).reduce(0, +)
        )
        
        let player6 = Player(
            name: "Player 6",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 6",
            defaultHeartrate: 85,
            heartrates: [85, 87, 86, 88],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 85, heartrates: [85, 87, 86, 88]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 85, heartrates: [85, 87, 86, 88]).reduce(0, +)
        )
        
        let player7 = Player(
            name: "Player 7",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 7",
            defaultHeartrate: 55,
            heartrates: [55, 57, 56, 58],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 55, heartrates: [55, 57, 56, 58]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 55, heartrates: [55, 57, 56, 58]).reduce(0, +)
        )
        
        let player8 = Player(
            name: "Player 8",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 8",
            defaultHeartrate:128,
            heartrates: [90, 92, 91, 93],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]).reduce(0, +)
        )
        
        return [player1, player2, player3, player4, player5, player6, player7, player8]
    }
}

struct GridCellView: View {
    
    let rank: Int
    let player: Player
    
    var body: some View {
        HStack(spacing: 50){
            Text("\(rank)") // 순위 1위부터 ~
                .font(.system(size: 20))
                .bold()
            
            changeRank()
            playerName()
            playerBpm()
            totalDeviation()
            
        }
        .frame(maxWidth: .infinity)
        //        .frame(maxHeight: .infinity) // 각 셀의 높이를 동적으로 조정
        //        .aspectRatio(contentMode: .fill)
        .frame(height: 79)
        .background(Color.mcGray)
        .cornerRadius(20)
        
    }
    
    // 순위 변동
    func changeRank() -> some View {
        VStack{
            // 경우의 수에 따라 삼각형 모양을 다르게 설정해야함
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(Color.mcBlue)
            
            Text("3")
                .font(.system(size: 12))
        }
    }
    
    // 유저 이름
    func playerName() -> some View {
        VStack{
            Text(player.name)
                .font(.system(size: 20))
        }
    }
    
    // 현재 심박수
    func playerBpm() -> some View {
        ZStack {
            Capsule()
                .frame(width: 114, height: 40)
                .foregroundColor(.black)
            
            HStack {
                Text("\(player.heartrates.last!)") // 심박수
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
        let deviationSum = player.differenceHeartrates.reduce(0, +)
        return ZStack {
            Capsule()
                .frame(width: 52, height: 40)
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
