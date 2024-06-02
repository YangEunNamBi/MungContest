//
//  RankListView.swift
//  MungContest
//
//  Created by 이상도 on 6/2/24.
//

import SwiftUI
import SwiftData

struct RankListView: View {
    
    let items = ["1", "2", "3", "4", "5","6"]
    
    let columns = [GridItem(.flexible())]
    
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
                .padding()
                .padding(.trailing, 20)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(items, id: \.self) { item in
                        GridCellView(item: item)
                    }
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(.green)
        .cornerRadius(30)
    }
}

struct GridCellView: View {
    
    let item: String
    
    var body: some View {
        HStack(spacing: 50){
            Text(item) // 순위 1위부터 ~
                .font(.system(size: 20))
                .bold()
            
            changeRank()
            playerName()
            playerBpm()
            totalDeviation()
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 72)
        .background(Color(UIColor(hex: "#1C1C1D")))
        .cornerRadius(20)
        
    }
    
    // 순위 변동
    func changeRank() -> some View {
        VStack{
            // 경우의 수에 따라 삼각형 모양을 다르게 설정해야함
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(.blue)
            
            Text("3")
                .font(.system(size: 12))
        }
    }
    
    // 유저 이름
    func playerName() -> some View {
        VStack{
            Text("해시")
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
                Text("128") // 심박수
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(Color(UIColor(hex: "#FFF7AB")))
                
                Text("bpm")
                    .font(.system(size: 14))
            }
        }
    }
    
    // 편차 합계
    func totalDeviation() -> some View {
        ZStack {
            Capsule()
                .frame(width: 52, height: 40)
                .foregroundColor(.black)
            
            HStack {
                Text("20")
                    .foregroundColor(Color(UIColor(hex: "#FFF7AB")))
                    .font(.system(size: 20))
                    .bold()
            }
        }
    }
    
}

// Text 속성 - 뷰 모디파이어
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
