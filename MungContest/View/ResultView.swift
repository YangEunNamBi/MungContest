//
//  ResultView.swift
//  MungContest
//
//  Created by 변준섭 on 8/16/24.
//

import SwiftUI
import SwiftData

struct ResultView: View {
    @ObservedObject var presenter: NVFlipCardPresenter
    @Environment(NavigationManager.self) var navigationManager
    @AppStorage("contestTitle") private var contestTitle: String = UserDefaults.standard.contestTitle
    
    @State var showingInfoToggle: Bool = false
    
    @State var animationCurrentIndex: Int = 0
    @State var rowIndex: [String] = ["기준", "1 차", "2 차", "3 차", "평균"]
    
    @Query() var players: [Player]
    
    @State var timesForMeasure: Int = 3
    @State var awardedList: [Player] = []
    @State var orderForAward: Int = 0
    @State var showingPlayer: Player = Player(name: "", profileImage: Data(), comment: "", defaultHeartrate: 0, heartrates: [0], differenceHeartrates: [0], resultHeartrate: 0)
    
    private let nameAward = ["멍대장", "멍부대장", "요동요동상", "멍장"]
    
    var body: some View {
        VStack{
            HStack{
                Text("mung contest")
                    .font(Font.custom("Poppins-Bold", size: 28))
                    .foregroundColor(Color.accentColor)
                Spacer()
            }
            Spacer()
            Text(contestTitle)
                .font(Font.custom("SpoqaHanSansNeo-Medium", size: 16))
                .foregroundColor(Color.mcGray300)
                .padding(.leading)
            if orderForAward < nameAward.count {
                Text("Who is the \(nameAward[orderForAward])?")
                    .font(Font.custom("SpoqaHanSansNeo-Bold", size: 28))
                    .foregroundColor(Color.white)
                    .padding(.leading)
            }
            HStack{
                Spacer()
                Button(action:{
                    showingInfoToggle = true
                    DispatchQueue.main.async{
                        showingPlayer = awardedList[orderForAward]
                        showItemsWithDelay()
                    }
                }, label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white.opacity(0.1), lineWidth: 2)
                            .frame(width: 360, height: 510)
                            .foregroundStyle(Color.mcGray800)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 1.0, green: 0.9686, blue: 0.6706), Color.white.opacity(0.1)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                            lineWidth: 4)
                                    .frame(width:320, height:470)
                            )
                        if presenter.isFlipped{
                            VStack{
                                if let image = UIImage(data:showingPlayer.profileImage){
                                    Image(uiImage:image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 260, height: 260)
                                        .clipShape(Circle())
                                }
                                Text("\(showingPlayer.name)")
                                    .font(.custom("SpoqaHanSansNeo-Bold", size: 40))
                                    .foregroundStyle(Color("AccentColor"))
                                    .scaleEffect(x: -1, y: 1)
                            }
                            
                        } else {
                            Image("WhoIsWinnerQuestionMark")
                                .frame(width:48, height:86)
                        }
                    }
                    .rotation3DEffect(.degrees(presenter.isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                    .animation(.default, value: presenter.isFlipped)
                })
                .disabled(showingInfoToggle)
                if showingInfoToggle {
                    VStack {
                        HStack {
                            Text(" ")
                                .frame(width: 80, alignment: .center)
                            Text("심박수")
                                .frame(width: 100, alignment: .center)
                            Text("편차")
                                .frame(width: 100, alignment: .center)
                        }
                        .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                        .foregroundStyle(Color("AccentColor"))
                        
                        ForEach(0..<animationCurrentIndex, id: \.self) { index in
                            if index == 0 {
                                Divider()
                                HStack {
                                    Text("기준")
                                        .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                                        .foregroundStyle(Color("AccentColor"))
                                        .frame(width: 80, alignment: .center)
                                    Text("\(showingPlayer.defaultHeartrate)")
                                        .frame(width: 100, alignment: .center)
                                    Text("")
                                        .frame(width: 100, alignment: .center)
                                }
                                .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                            } else if index != timesForMeasure+1 {
                                Divider()
                                HStack {
                                    Text("\(index)차")
                                        .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                                        .foregroundStyle(Color("AccentColor"))
                                        .frame(width: 80, alignment: .center)
                                    Text("\(showingPlayer.heartrates[index-1])")
                                        .frame(width: 100, alignment: .center)
                                    Text("\(showingPlayer.differenceHeartrates[index-1])")
                                        .frame(width: 100, alignment: .center)
                                }
                                .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                            } else {
                                Divider()
                                HStack {
                                    Text("평균")
                                        .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                                        .foregroundStyle(Color("AccentColor"))
                                        .frame(width: 80, alignment: .center)
                                    Text("\(showingPlayer.heartrates.reduce(0,+) / showingPlayer.heartrates.count)")
                                        .frame(width: 100, alignment: .center)
                                    Text("\(showingPlayer.resultHeartrate)")
                                        .frame(width: 100, alignment: .center)
                                }
                                .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                            }
                            
                        }
                        Spacer()
                        if presenter.isFlipped{
                            if orderForAward != 3{
                                Button(action:{
                                    orderForAward += 1
                                    showingInfoToggle = false
                                    presenter.isFlipped = false
                                }, label:{
                                    HStack {
                                        Text("수상 축하드립니다!")
                                            .font(.system(size: 24))
                                            .bold()
                                            .foregroundColor(Color.black)
                                    }
                                    .padding(.vertical, 14)
                                    .padding(.horizontal, 30)
                                    .background(Color.accentColor)
                                    .cornerRadius(25)
                                })
                            } else{
                                Button(action:{
                                    navigationManager.push(to: .last)
                                }, label:{
                                    HStack {
                                        Text("최종 결과 화면으로")
                                            .font(.system(size: 24))
                                            .bold()
                                            .foregroundColor(Color.black)
                                    }
                                    .padding(.vertical, 14)
                                    .padding(.horizontal, 30)
                                    .background(Color.accentColor)
                                    .cornerRadius(25)
                                })
                            }
                            
                        }
                    }
                    .frame(width: 400, height: 470)
                }
                Spacer()
            }
            Spacer()
        }
        .onAppear{
            let sortedPlayers = players.sorted { $0.resultHeartrate < $1.resultHeartrate }
            if players.count > 0 {
                timesForMeasure = players[0].heartrates.count
            }
            DispatchQueue.main.async{
                awardedList = [sortedPlayers[2],
                               sortedPlayers[1],
                               sortedPlayers[sortedPlayers.count-1],
                               sortedPlayers[0]
                ]
            }
        }
    }
    func showItemsWithDelay() {
        for index in 0..<timesForMeasure+2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 1) {
                withAnimation {
                    animationCurrentIndex = index + 1
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(timesForMeasure+2)) {
            presenter.isFlipped = true
        }
    }
}

//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView(presenter: NVFlipCardPresenter())
//            .previewInterfaceOrientation(.landscapeLeft)
//            .preferredColorScheme(.dark)
//    }
//}

protocol NVFlipCardPresenterProtocol: ObservableObject {
    var isFlipped: Bool { get }
    func flipButtonTapped()
}

class NVFlipCardPresenter: NVFlipCardPresenterProtocol {
    @Published var isFlipped: Bool = false
    
    func flipButtonTapped() {
        isFlipped.toggle()
    }
}
