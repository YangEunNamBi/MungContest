//
//  RankView.swift
//  MungContest
//
//  Created by 이상도 on 6/2/24.
//

import SwiftUI

struct RankView: View {
    
    var players: [Player] = []
    
    let columns: [GridItem] = [
        GridItem(.flexible())
    ]
    
    init() {
        players = createDummyPlayers().sorted { $0.resultHeartrate < $1.resultHeartrate }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("순위권")
                    .font(Font.custom("Spoqa Han Sans Neo", size: 16)
                        .weight(.bold)
                    )
                    .foregroundColor(Color.mcGray)
                    .padding(.leading)
                
                Spacer()
            }
            
            
            HStack(spacing: 20) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.mcGray)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        
                    VStack {
                        Text("⚠️")
                            .font(.system(size: 28))
                            .foregroundColor(.black)
                        
                        VStack {
                            ZStack {
                                Circle()
                                    
                                
                                Image(systemName: "house")
                                    .foregroundColor(.black)
                                    .font(.system(size: 80))
                            }
                        }
                        .padding(.horizontal, 30)
                        
                        Text(players[0].name ?? "")
                            .padding(.top, 10)
                    }
                    
                }
                ZStack {
                    Rectangle()
                        .foregroundColor(.mcGray)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        
                    VStack {
                        Text("⚠️")
                            .font(.system(size: 28))
                            .foregroundColor(.black)
                        
                        VStack {
                            ZStack {
                                Circle()
                                    
                                
                                Image(systemName: "house")
                                    .foregroundColor(.black)
                                    .font(.system(size: 80))
                            }
                        }
                        .padding(.horizontal, 30)
                        
                        Text(players[1].name ?? "")
                            .padding(.top, 10)
                    }
                    
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.mcGray)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        
                    VStack {
                        Text("⚠️")
                            .font(.system(size: 28))
                            .foregroundColor(.black)
                        
                        VStack {
                            ZStack {
                                Circle()
                                    
                                
                                Image(systemName: "house")
                                    .foregroundColor(.black)
                                    .font(.system(size: 80))
                            }
                        }
                        .padding(.horizontal, 30)
                        
                        Text(players[2].name ?? "")
                            .padding(.top, 10)
                    }
                    
                }
            }
            
            HStack {
                Text("하위권")
                    .font(Font.custom("Spoqa Han Sans Neo", size: 16)
                        .weight(.bold)
                    )
                    .foregroundColor(Color.mcGray)
                    .padding(.leading)
                Spacer()
            }
            
            HStack(spacing: 20) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.mcGray)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        
                    VStack {
                        Text("⚠️")
                            .font(.system(size: 28))
                            .foregroundColor(.black)
                        
                        VStack {
                            ZStack {
                                Circle()
                                    
                                
                                Image(systemName: "house")
                                    .foregroundColor(.black)
                                    .font(.system(size: 80))
                            }
                        }
                        .padding(.horizontal, 30)
                        
                        Text(players[players.count-1].name ?? "")
                            .padding(.top, 10)
                    }
                    
                }
                ZStack {
                    Rectangle()
                        .foregroundColor(.mcGray)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        
                    VStack {
                        Text("⚠️")
                            .font(.system(size: 28))
                            .foregroundColor(.black)
                        
                        VStack {
                            ZStack {
                                Circle()
                                    
                                
                                Image(systemName: "house")
                                    .foregroundColor(.black)
                                    .font(.system(size: 80))
                            }
                        }
                        .padding(.horizontal, 30)
                        
                        Text(players[players.count-2].name ?? "")
                            .padding(.top, 10)
                    }
                    
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.mcGray)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        
                    VStack {
                        Text("⚠️")
                            .font(.system(size: 28))
                            .foregroundColor(.black)
                        
                        VStack {
                            ZStack {
                                Circle()
                                    
                                
                                Image(systemName: "house")
                                    .foregroundColor(.black)
                                    .font(.system(size: 80))
                            }
                        }
                        .padding(.horizontal, 30)
                        
                        Text(players[players.count-3].name ?? "")
                            .padding(.top, 10)
                    }
                    
                }
            }
//            LazyHGrid(rows: columns, spacing: 15) {
//                ForEach(players.suffix(3).reversed(), id: \.name) { player in
//                    RankCellView(player: player)
//                }
//            }
//            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // 임시 데이터
    func createDummyPlayers() -> [Player] {
        func calculateDifferenceHeartrates(defaultHeartrate: Int, heartrates: [Int]) -> [Int] {
            return heartrates.map { abs(defaultHeartrate - $0) }
        }
        
        let player1 = Player(
            name: "나다",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 1",
            defaultHeartrate: 70,
            heartrates: [70, 75, 73, 72],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 70, heartrates: [70, 75, 73, 72]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 70, heartrates: [70, 75, 73, 72]).reduce(0, +)
        )
        
        let player2 = Player(
            name: "마스",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 2",
            defaultHeartrate: 115,
            heartrates: [65, 68, 66, 67],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 115, heartrates: [65, 68, 66, 67]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 115, heartrates: [65, 68, 66, 67]).reduce(0, +)
        )
        
        let player3 = Player(
            name: "태오",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 3",
            defaultHeartrate: 80,
            heartrates: [80, 82, 81, 79],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 80, heartrates: [80, 82, 81, 79]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 80, heartrates: [80, 82, 81, 79]).reduce(0, +)
        )
        
        let player4 = Player(
            name: "라라",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 4",
            defaultHeartrate: 75,
            heartrates: [75, 77, 76, 78],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 75, heartrates: [75, 77, 76, 78]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 75, heartrates: [75, 77, 76, 78]).reduce(0, +)
        )
        
        let player5 = Player(
            name: "예",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 5",
            defaultHeartrate: 110,
            heartrates: [60, 62, 61, 63],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 110, heartrates: [60, 62, 61, 63]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 110, heartrates: [60, 62, 61, 63]).reduce(0, +)
        )
        
        let player6 = Player(
            name: "혜디",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 6",
            defaultHeartrate: 85,
            heartrates: [85, 87, 86, 88],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 85, heartrates: [85, 87, 86, 88]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 85, heartrates: [85, 87, 86, 88]).reduce(0, +)
        )
        
        let player7 = Player(
            name: "제니스",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 7",
            defaultHeartrate: 55,
            heartrates: [55, 57, 56, 58],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 55, heartrates: [55, 57, 56, 58]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 55, heartrates: [55, 57, 56, 58]).reduce(0, +)
        )
        
        let player8 = Player(
            name: "베로",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 8",
            defaultHeartrate:128,
            heartrates: [90, 92, 91, 93],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]).reduce(0, +)
        )
        
        let player9 = Player(
            name: "원",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 8",
            defaultHeartrate:128,
            heartrates: [90, 92, 91, 93],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]).reduce(0, +)
        )
        
        let player10 = Player(
            name: "하래",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 8",
            defaultHeartrate:128,
            heartrates: [90, 92, 91, 93],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]).reduce(0, +)
        )
        
        let player11 = Player(
            name: "자운드",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 8",
            defaultHeartrate:128,
            heartrates: [90, 92, 91, 93],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]).reduce(0, +)
        )
        
        let player12 = Player(
            name: "젠",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 8",
            defaultHeartrate:128,
            heartrates: [90, 92, 91, 93],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]).reduce(0, +)
        )
        
        let player13 = Player(
            name: "루시아",
            profileImage: Data(), // 실제 이미지 데이터로 대체 필요
            comment: "Comment 8",
            defaultHeartrate:128,
            heartrates: [90, 92, 91, 93],
            differenceHeartrates: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]),
            resultHeartrate: calculateDifferenceHeartrates(defaultHeartrate: 128, heartrates: [90, 92, 91, 93]).reduce(0, +)
        )
        return [player1, player2, player3, player4, player5, player6, player7, player8,player9, player10, player11, player12, player13]
    }
}


struct RankCellView: View {
    
    var player: Player
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill()
                .cornerRadius(10)
            
            VStack {
                Text(player.name)
                    .font(.headline)
                    .foregroundColor(.black)
                Text("Result: \(player.resultHeartrate)")
                    .foregroundColor(.white)
            }
        }
    }
}

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView()
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}
