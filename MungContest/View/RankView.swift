//
//  RankView.swift
//  MungContest
//
//  Created by 이상도 on 6/2/24.
//

import SwiftUI
import SwiftData

struct RankView: View {
    
    let columns: [GridItem] = [GridItem(.flexible())]
    
    @Query var players: [Player]
    var sortedPlayers: [Player] {
        players.sorted { $0.resultHeartrate < $1.resultHeartrate }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("순위권")
                    .font(Font.custom("SpoqaHanSansNeo-Bold", size: 16))
                    .foregroundColor(Color.mcGray300)
                    .padding(.leading)
                
                Spacer()
            }
            
            // 상위권 1위 ~ 3위
            HStack(spacing: 20) {
                ZStack {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(hex: "#FFF7AB").opacity(0.2), Color(hex: "#FFFFFF").opacity(0.2)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                    VStack {
                        Spacer() // 상단 공간을 차지하는 Spacer 추가
                        Rectangle()
                            .fill(Color.mcGray800)
                            .frame(height: UIScreen.main.bounds.height / 6) // 모서리 둥글게 설정
                            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                    }
                    
                    VStack {
                        HStack{
                            Text("1")
                                .fontWeight(.heavy)
                                .font(Font.custom("Poppins-Bold", size: 24))
                                .foregroundColor(Color(hex: "FFFFFF").opacity(0.2))
                                .padding(.leading, 20)
                                .padding(.top, 10)
                            Spacer()
                        }
                        
                        Image("1stUnion")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 21 )
                        
                        Image(uiImage: UIImage(data: sortedPlayers[0].profileImage) ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .padding(.horizontal, 30)
                        
                        Text(sortedPlayers[0].name ?? "")
                            .font(Font.custom("SpoqaHanSansNeo-Bold", size: 16))
                            .padding(.top, 10)
                            .foregroundColor(.mcGray300)
                            .padding(.bottom, 20)
                    }
                    .padding(.bottom, 20)
                    
                }
                ZStack {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(hex: "#FFFFFF").opacity(0.2), Color(hex: "#AAAAAA").opacity(0.2)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                    
                    VStack {
                        Spacer() // 상단 공간을 차지하는 Spacer 추가
                        Rectangle()
                            .fill(Color.mcGray800)
                            .frame(height: UIScreen.main.bounds.height / 6) // 모서리 둥글게 설정
                            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                    }
                    
                    VStack {
                        HStack{
                            Text("2")
                                .fontWeight(.heavy)
                                .font(Font.custom("Poppins-Bold", size: 24))
                                .foregroundColor(Color(hex: "FFFFFF").opacity(0.2))
                                .padding(.leading, 20)
                                .padding(.top, 10)
                            Spacer()
                        }
                        Image("2ndUnion")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 21 )
                        
                        Image(uiImage: UIImage(data: sortedPlayers[1].profileImage) ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .padding(.horizontal, 30)
                        
                        Text(sortedPlayers[1].name ?? "")
                            .font(Font.custom("SpoqaHanSansNeo-Bold", size: 16))
                            .padding(.top, 10)
                            .foregroundColor(.mcGray300)
                            .padding(.bottom, 20)
                    }
                    .padding(.bottom, 20)
                }
                
                ZStack {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(hex: "#CCB17F").opacity(0.2), Color(hex: "#FFFFFF").opacity(0.2)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                    
                    VStack {
                        Spacer() // 상단 공간을 차지하는 Spacer 추가
                        Rectangle()
                            .fill(Color.mcGray800)
                            .frame(height: UIScreen.main.bounds.height / 6) // 모서리 둥글게 설정
                            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                    }
                    
                    VStack {
                        HStack{
                            Text("3")
                                .fontWeight(.heavy)
                                .font(Font.custom("Poppins-Bold", size: 24))
                                .foregroundColor(Color(hex: "FFFFFF").opacity(0.2))
                                .padding(.leading, 20)
                                .padding(.top, 10)
                            Spacer()
                        }
                        Image("3rdUnion")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 21 )
                        
                        Image(uiImage: UIImage(data: sortedPlayers[2].profileImage) ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .padding(.horizontal, 30)
                        
                        Text(sortedPlayers[2].name ?? "")
                            .font(Font.custom("SpoqaHanSansNeo-Bold", size: 16))
                            .padding(.top, 10)
                            .foregroundColor(.mcGray300)
                            .padding(.bottom, 20)
                    }
                    .padding(.bottom, 20)
                }
            }
            .padding(.bottom, 10)
            
            HStack {
                Text("하위권")
                    .font(Font.custom("SpoqaHanSansNeo-Bold", size: 16))
                    .foregroundColor(Color.mcGray300)
                    .padding(.leading)
                
                Spacer()
            }
            .padding(.top, 10)
            
            // 하위권 3명
            HStack(spacing: 20) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.mcGray800)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                    
                    VStack {
                        Text("⚠️")
                            .font(.system(size: 28))
                            .foregroundColor(.black)
                        
                        Image(uiImage: UIImage(data: sortedPlayers[sortedPlayers.count-1].profileImage) ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .padding(.horizontal, 30)
                        
                        Text(sortedPlayers[sortedPlayers.count-1].name ?? "")
                            .font(Font.custom("SpoqaHanSansNeo-Bold", size: 16))
                            .padding(.top, 10)
                            .foregroundColor(.mcGray300)
                    }
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.mcGray800)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                    
                    VStack {
                        Text("⚠️")
                            .font(.system(size: 28))
                            .foregroundColor(.black)
                        
                        Image(uiImage: UIImage(data: sortedPlayers[sortedPlayers.count-2].profileImage) ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .padding(.horizontal, 30)
                        
                        Text(sortedPlayers[sortedPlayers.count-2].name ?? "")
                            .font(Font.custom("SpoqaHanSansNeo-Bold", size: 16))
                            .padding(.top, 10)
                            .foregroundColor(.mcGray300)
                    }
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.mcGray800)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                    
                    VStack {
                        Text("⚠️")
                            .font(.system(size: 28))
                            .foregroundColor(.black)
                        
                        Image(uiImage: UIImage(data: sortedPlayers[sortedPlayers.count-3].profileImage) ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .padding(.horizontal, 30)
                        
                        Text(sortedPlayers[sortedPlayers.count-3].name ?? "")
                            .font(Font.custom("SpoqaHanSansNeo-Bold", size: 16))
                            .padding(.top, 10)
                            .foregroundColor(.mcGray300)
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
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView()
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}
