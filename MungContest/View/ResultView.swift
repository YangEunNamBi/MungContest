//
//  ResultView.swift
//  MungContest
//
//  Created by 변준섭 on 8/16/24.
//

import SwiftUI

struct ResultView: View {
    var body: some View {
        VStack{
            HStack{
                Text("mung contest")
                    .font(Font.custom("Poppins-Bold", size: 28))
                    .foregroundColor(Color.accentColor)
                Spacer()
            }
            Spacer()
            Text("원의 1차 멍때리기 대회")
                .font(Font.custom("SpoqaHanSansNeo-Medium", size: 16))
                .foregroundColor(Color.mcGray300)
                .padding(.leading)
            Text("Who is the Winner?")
                .font(Font.custom("SpoqaHanSansNeo-Bold", size: 28))
                .foregroundColor(Color.white)
                .padding(.leading)
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
                Image("WhoIsWinnerQuestionMark")
                    .frame(width:48, height:86)
            }
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}
