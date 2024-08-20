//
//  StandbyViewOverlay.swift
//  MungContest
//
//  Created by 변준섭 on 8/19/24.
//

import SwiftUI
import SwiftData

struct StandbyViewOverlay: View {
    
    @Query var players: [Player]
    @Environment(\.modelContext) var modelContext
    
    @State private var showAlert = false
    @State private var playerToDelete: Player?
    
    var body: some View {
        VStack{
            HStack{
                Text("참가자 명단")
                    .font(Font.custom("SpoqaHanSansNeo-Medium", size: 30))
                    .foregroundColor(Color.accentColor)
                    .padding(.leading)
            }.frame(height:80)
            Divider()
            ScrollView{
                ForEach(players, id:\.self) { player in
                    HStack{
                        Spacer()
                        Text(player.name)
                            .font(Font.custom("SpoqaHanSansNeo-Medium", size: 30))
                            .foregroundColor(Color.white)
                            .padding(.leading)
                            .frame(width:200)
                        Spacer()
                        Button(action:{
                            DispatchQueue.main.async {
                                playerToDelete = player
                                showAlert = true
                            }
                        }, label:{
                            Image(systemName: "trash")
                                .resizable()
                                .foregroundColor(Color.red)
                                .frame(width: 22, height: 22)
                        })
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Delete Player"),
                                message: Text("Are you sure you want to delete \(playerToDelete?.name ?? "this player")?"),
                                primaryButton: .destructive(Text("Delete")) {
                                    if let playerToDelete = playerToDelete {
                                        DispatchQueue.main.async {
                                            modelContext.delete(playerToDelete)
                                            try? modelContext.save()
                                        }
                                    }
                                },
                                secondaryButton: .cancel()
                            )
                        }
                        Spacer()
                    }
                    .padding()
                    Divider()
                }
            }
        }
        
    }
}
