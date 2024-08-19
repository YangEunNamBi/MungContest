//
//  RankListCellView.swift
//  MungContest
//
//  Created by 이상도 on 8/17/24.
//

import SwiftUI

struct RankListCellView: View {
    
    let rank: Int // 순위 표기
    let player: Player // 데이터
    
    let previousRank: Int // 이전순위 (순위변동)
    let currentRank: Int
    
    var body: some View {
        HStack {
            Text("\(rank)") // 순위 1위부터
                .font(.system(size: 20, weight: .bold))
                .frame(width: 30, alignment: .center)
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
    
    /// 순위변동
    func changeRank() -> some View {
        let rankChange = currentRank - previousRank
        return HStack {
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
                Image(systemName: "arrowtriangle.up.fill") // 레이아웃유지위해서 일단 임시로 박아둠
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.clear)
                Text("-")
                    .font(.system(size: 12))
            }
        }
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
    
    /// 현재 심박수
    func playerBpm() -> some View {
        ZStack {
            Capsule()
                .frame(width: 114, height: 40)
                .foregroundColor(.black)
            
            HStack {
                Text("\(player.heartrates.filter { $0 != 0 }.last ?? 0)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.accentColor)
                
                Text("bpm")
                    .font(.system(size: 14))
            }
        }
    }
    
    // 편차 합계
    func totalDeviation() -> some View {
        let nonZeroCount = player.heartrates.filter { $0 != 0 }.count
        let deviationValue: Int
        
        if nonZeroCount > 0 {
            deviationValue = player.resultHeartrate / nonZeroCount
        } else {
            deviationValue = 0 // Handle division by zero if there are no non-zero heart rates
        }
        
        return ZStack {
            Capsule()
                .frame(width: 70, height: 40)
                .foregroundColor(.black)
            
            HStack {
                Text("\(deviationValue)")
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 20, weight: .bold))
            }
        }
    }
}
