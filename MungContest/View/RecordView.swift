//
//  RecordView.swift
//  MungContest
//
//  Created by 변준섭 on 6/19/24.
//

import SwiftUI
import SwiftData

struct RecordView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    @FocusState private var showKeyboard: Bool
    
    @State var playerToInput: Player = Player(name: "준요", profileImage: Data(), comment: "내가 젠은 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0)
    @State var numToInput: String = "0"
    @State var columnIndex: Int = 0
    @State var rowIndex: Int = 0
    
    @Query() var players: [Player]

    enum CalcButton: String {
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case zero = "0"
        case enter = "􀄴"
        case empty = ""
        
        var buttonColor: Color {
            switch self {
            case .enter:
                return .orange
            default:
                return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
            }
        }
    }
        
    var body: some View {
        
        let buttons: [[CalcButton]] = [
            [.one, .two, .three],
            [.four, .five, .six],
            [.seven, .eight, .nine]
        ]
        
        HStack{
            ScrollView{
                HStack{
                    VStack{
                        Text("번호")
                            .font(.custom("SpoqaHanSansNeo-Bold", size:20))
                            .foregroundStyle(Color("AccentColor"))
                            .frame(height:45)
                        Divider()
                        ForEach(players.indices){ index in
                            Text("\(index+1)")
                                .font(.custom("SpoqaHanSansNeo-Medium", size:20))
                                .frame(height:45)
                            Divider()
                        }
                    }.frame(width:100)
                    VStack{
                        Text("이름")
                            .font(.custom("SpoqaHanSansNeo-Bold", size:20))
                            .foregroundStyle(Color("AccentColor"))
                            .frame(height:45)
                        Divider()
                        ForEach(players){ player in
                            Text(player.name)
                                .font(.custom("SpoqaHanSansNeo-Medium", size:20))
                                .frame(height:45)
                            Divider()
                        }
                    }.frame(width:100)
                    VStack {
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack{
                                Text("초기")
                                    .font(.custom("SpoqaHanSansNeo-Bold", size:20))
                                    .foregroundStyle(Color("AccentColor"))
                                    .frame(width:96)
                                Divider()
                                ForEach(players[0].heartrates.indices, id: \.self){ index in
                                    Text("\(index+1)차")
                                        .font(.custom("SpoqaHanSansNeo-Bold", size:20))
                                        .foregroundStyle(Color("AccentColor"))
                                        .frame(width:96)
                                    Divider()
                                }
                            }.frame(height:45)
                            Divider()
                            ForEach(players.indices) { index in
                                LazyHStack {
                                    Button(action:{
                                        playerToInput = players[index]
                                        numToInput = String(players[index].defaultHeartrate)
                                        columnIndex = 0
                                        rowIndex = index
                                    }, label:{
                                        if index == rowIndex && columnIndex==0{
                                            Text(numToInput)
                                                .font(.custom("SpoqaHanSansNeo-Medium", size:20))
                                                .frame(width:96)
                                                .background(
                                                    Rectangle()
                                                        .opacity(0.5)
                                                        .foregroundStyle(Color.gray))
                                        } else{
                                            Text("\(players[index].defaultHeartrate)")
                                                .font(.custom("SpoqaHanSansNeo-Medium", size:20))
                                                .foregroundStyle(Color("mcGray300"))
                                                .frame(width:96)
                                        }
                                    })
                                    Divider()
                                        .background(Color.white)
                                    ForEach(players[0].heartrates.indices , id: \.self) { colIndex in
                                        Button(action:{
                                            playerToInput = players[index]
                                            numToInput = String(players[index].heartrates[colIndex])
                                            columnIndex = colIndex+1
                                            rowIndex = index
                                        }, label:{
                                            if index == rowIndex && columnIndex == colIndex+1{
                                                Text(numToInput)
                                                    .font(.custom("SpoqaHanSansNeo-Medium", size:20))
                                                //                                                        .foregroundStyle(Color("mcGray300"))
                                                    .frame(width:96)
                                                    .background(
                                                        Rectangle()
                                                            .opacity(0.5)
                                                            .foregroundStyle(Color.gray))
                                            } else{
                                                Text("\(players[index].heartrates[colIndex])")
                                                    .font(.custom("SpoqaHanSansNeo-Medium", size:20))
                                                    .foregroundStyle(Color("mcGray300"))
                                                    .frame(width:96)
                                            }
                                        })
                                        Divider()
                                            .background(Color.white)
                                    }
                                }
                                .frame(height:45)
                                Divider()
                            }
                        }
                    }.frame(width:470)
                }
            }
            Spacer()
            
            VStack {
                Spacer()
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                    .frame(width:396, height:516)
                    .foregroundStyle(Color("mcGray800"))
                    .overlay{
                        HStack{
                            // 계산기 뷰
                            VStack{
                                // 계산기 위에 현재 숫자가 뜨게 할지?
                                //                            HStack {
                                //                                Text(numToInput)
                                //                            }
                                ForEach(buttons, id: \.self) { row in
                                    HStack(spacing: 12) {
                                        ForEach(row, id: \.self) { item in
                                            Button(action: {
                                                if numToInput == "0"{
                                                    numToInput = item.rawValue
                                                } else{
                                                    numToInput += item.rawValue
                                                }
                                            }, label: {
                                                Text(item.rawValue)
                                                    .font(.custom("SpoqaHanSansNeo-Bold", size:40))
                                                    .font(.system(size: 32))
                                                    .frame(width: 100, height: 100)
                                                    .foregroundColor(Color("AccentColor"))
                                                    .background(item.rawValue != "" ? Color.black : Color("mcLightGray"))
                                                    .cornerRadius(50)
                                                
                                            })
                                        }
                                    }
                                    .padding(.bottom, 3)
                                }
                                HStack{
                                    Button(action:{
                                        if numToInput.count != 1{
                                            numToInput = String(numToInput.dropLast())
                                        } else {
                                            numToInput = "0"
                                        }
                                    }, label:{
                                        Text("Del")
                                            .font(.custom("SpoqaHanSansNeo-Bold", size:30))
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(Color("AccentColor"))
                                            .background(Color.black)
                                            .cornerRadius(50)
                                    })
                                    Button(action:{
                                        if numToInput == "0"{
                                            numToInput = "0"
                                        } else{
                                            numToInput += "0"
                                        }
                                    }, label:{
                                        Text("0")
                                            .font(.custom("SpoqaHanSansNeo-Bold", size:40))
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(Color("AccentColor"))
                                            .background(Color.black)
                                            .cornerRadius(50)
                                    })
                                    Button(action:{
                                        if columnIndex == 0{
                                            players[rowIndex].defaultHeartrate = Int(numToInput) ?? 0
                                            if rowIndex == players.count-1 {
                                                rowIndex = 0
                                            }else{
                                                rowIndex += 1
                                            }                                            
                                            numToInput = "0"
                                        } else{
                                            DispatchQueue.main.asyncAfter(deadline: .now()){
                                                players[rowIndex].heartrates[columnIndex-1] = Int(numToInput) ?? 0
                                                if numToInput != "0"{
                                                    players[rowIndex].differenceHeartrates[columnIndex-1] = abs(players[rowIndex].defaultHeartrate - (Int(numToInput) ?? 0))
                                                }
                                                players[rowIndex].resultHeartrate = players[rowIndex].differenceHeartrates.reduce(0, +)
                                                
                                                if rowIndex == players.count-1 {
                                                    rowIndex = 0
                                                } else{
                                                    rowIndex += 1
                                                }
                                                numToInput = "0"
                                            }
                                        }
                                    }, label:{
                                        Text("Input")
                                            .font(.custom("SpoqaHanSansNeo-Bold", size:30))
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(Color("AccentColor"))
                                            .background(Color.black)
                                            .cornerRadius(50)
                                    })
                                }
                            }
                        }
                    }
            }
        }
    }
}
//}

//struct RecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordView()
//            .environment(NavigationManager())
//            .previewInterfaceOrientation(.landscapeLeft)
//            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
//    }
//}

func calculateDifferencesWithDefault(_ array: [Int], defaultValue: Int) -> [Int] {
    var result: [Int] = []
    
    for value in array {
        if value != 0{
            let difference = abs(value - defaultValue)
            result.append(difference)
        }
    }
    return result
}
