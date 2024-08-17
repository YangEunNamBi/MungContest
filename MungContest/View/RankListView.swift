import SwiftUI
import SwiftData

class RankViewModel: ObservableObject {
    
    @Published var currentRanks: [UUID: Int] = [:] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    @Published var previousRanks: [UUID: Int] = [:] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    private let currentRanksKey = "currentRanks"
    private let previousRanksKey = "previousRanks"
    
    init() {
        loadFromUserDefaults()
    }
    
    private func saveToUserDefaults() {
        UserDefaults.standard.set(currentRanks.map { "\($0.key.uuidString):\($0.value)" }, forKey: currentRanksKey)
        UserDefaults.standard.set(previousRanks.map { "\($0.key.uuidString):\($0.value)" }, forKey: previousRanksKey)
    }
    
    private func loadFromUserDefaults() {
        if let currentRanksData = UserDefaults.standard.stringArray(forKey: currentRanksKey) {
            currentRanks = Dictionary(uniqueKeysWithValues: currentRanksData.map {
                let parts = $0.split(separator: ":")
                return (UUID(uuidString: String(parts[0]))!, Int(parts[1])!)
            })
        }
        
        if let previousRanksData = UserDefaults.standard.stringArray(forKey: previousRanksKey) {
            previousRanks = Dictionary(uniqueKeysWithValues: previousRanksData.map {
                let parts = $0.split(separator: ":")
                return (UUID(uuidString: String(parts[0]))!, Int(parts[1])!)
            })
        }
    }
}

struct RankListView: View {
    
    let columns = [GridItem(.flexible())]
    
    @State private var currentStartIndex = 0
    private let interval: TimeInterval = 5.0 // List 체인지 되는 시간(초)
    
    @StateObject private var viewModel = RankViewModel()
    
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
                        RankListCellView(rank: sortedPlayers.firstIndex(where: { $0.id == player.id })! + 1, player: player, previousRank: viewModel.previousRanks[player.id] ?? 0, currentRank: viewModel.currentRanks[player.id] ?? 0)
                    }
                }
                .frame(maxHeight: .infinity)
                
                NavigationLink(destination: LastView()) {
                                           Text("Go to LastView")
                                               .font(.system(size: 16, weight: .bold))
                                               .foregroundColor(Color.accentColor)
                                               .padding()
                                               .background(Color.black)
                                               .cornerRadius(10)
                                       }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(30)
        .onAppear {
            startTimer() // 이 뷰가 뜰때마다 timer의 시간마다 List를 자동으로 넘기면서 보여줍니다.
            updateRanks()
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            if currentStartIndex + 6 >= players.count {
                currentStartIndex = 0
            } else {
                currentStartIndex += 6
            }
        }
    }
    
    /// 이전 대비 순위변동폭 보여주는 함수
    private func updateRanks() {
        var newRanks: [UUID: Int] = [:]
        
        for (index, player) in sortedPlayers.enumerated() {
            newRanks[player.id] = index + 1
        }
        
        viewModel.previousRanks = viewModel.currentRanks
        print("previousRanks : \(viewModel.previousRanks)")
        viewModel.currentRanks = newRanks
        print("currentRanks : \(viewModel.currentRanks)")
    }
}

struct RankListView_Previews: PreviewProvider {
    static var previews: some View {
        RankListView()
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}
