//
//  AddPlayerView.swift
//  MungContest
//
//  Created by Hyun Jaeyeon on 8/16/24.
//

import SwiftUI

struct AddPlayerView: View {
    @Environment(\.modelContext) var modelContext
    @State private var name: String = ""
    @State private var comment: String = ""
    
    func addNewPlayer(_ player: Player) {
        do {
            modelContext.insert(player)
            try modelContext.save()
        } catch {
            print("Failed to save player: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Group{
                Text("이름")
                    .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                    .foregroundColor(.accent)
                
                TextField("이름을 입력해주세요", text: $name)
                    .font(.custom("SpoqaHanSansNeo-Medium", size: 28))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.mcGray700)
                    )
                    .padding(.bottom)
            }
            
            Group{
                Text("각오")
                    .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                    .foregroundColor(.accent)
                
                TextField("각오를 입력해주세요", text: $comment, axis: .vertical)
                    .multilineTextAlignment(.leading)
                    .font(.custom("SpoqaHanSansNeo-Medium", size: 28))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                    .frame(minHeight: 120, alignment: .top)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.mcGray700)
                    )
                    .padding(.bottom)
            }
            
            Group{
                Text("이미지")
                    .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                    .foregroundColor(.accent)
                
                Button(action: {}){
                    Text("이미지")
                        .font(.custom("SpoqaHanSansNeo-Medium", size: 28))
                        .foregroundColor(.mcGray300)
                        .padding(.vertical, 24)
                        .padding(.horizontal, 15.5)
                        .background(Color.mcGray700)
                        .cornerRadius(16)
                }
                .padding(.bottom)
            }
        }
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.mcGray800)
        )
        .frame(width: 542)
    }
}

#Preview {
    AddPlayerView()
}
