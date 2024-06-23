//
//  RankView.swift
//  MungContest
//
//  Created by 이상도 on 6/2/24.
//

import SwiftUI

struct RankView: View {
    
    var body: some View {
        VStack(spacing: 0){
            VStack{
                HStack{
                    HStack{
                        Text("상위 랭킹")
                            .padding(.top, 30)
                            .padding(.leading, 30)
                            .bold()
                            .font(.system(size: 16))
                        
                        Spacer()
                    }
                }
                HStack{
                    VStack{
                        Spacer()
                        Circle()
                            .frame(width: 60, height: 60)
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 125)
                                .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 10))
                            
                            Text("2")
                                . font(Font.custom("Spoqa Han Sans Neo", size: 24)
                                    .weight(.bold)
                                )
                                .foregroundColor(.black)
                                .padding(.bottom, 60)
                        }
                    }
                    VStack{
                        Spacer()
                        Circle()
                            .frame(width: 60, height: 60)
                        
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 150)
                                .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 10))
                            
                            Text("1")
                                . font(Font.custom("Spoqa Han Sans Neo", size: 24)
                                    .weight(.bold)
                                )
                                .foregroundColor(.black)
                                .padding(.bottom, 80)
                        }
                    }
                    
                    VStack{
                        Spacer()
                        Circle()
                            .frame(width: 60, height: 60)
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 10))
                            
                            Text("3")
                                . font(Font.custom("Spoqa Han Sans Neo", size: 24)
                                    .weight(.bold)
                                )
                                .foregroundColor(.black)
                                .padding(.bottom, 40)
                        }
                    }
                }
            }
            
            Rectangle()
                .frame(width: 400, height: 1)
                .foregroundColor(Color.gray)
                .background(DashedLine())
//            Divider()
//                .frame(width: 100)
            
            VStack{
                HStack{
                    VStack{
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .clipShape(CustomCorners(corners: [.bottomLeft, .bottomRight], radius: 10))
                            
                            Text("3")
                                . font(Font.custom("Spoqa Han Sans Neo", size: 24)
                                    .weight(.bold)
                                )
                                .foregroundColor(.black)
                                .padding(.top, 40)
                            
                            
                        }
                        
                        Circle()
                            .frame(width: 60, height: 60)
                        
                        Spacer()
                        
                    }
                    VStack{
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 150)
                                .clipShape(CustomCorners(corners: [.bottomLeft, .bottomRight], radius: 10))
                            
                            Text("1")
                                . font(Font.custom("Spoqa Han Sans Neo", size: 24)
                                    .weight(.bold)
                                )
                                .foregroundColor(.black)
                                .padding(.top, 80)
                        }
                        
                        Circle()
                            .frame(width: 60, height: 60)
                        
                        Spacer()
                        
                    }
                    VStack{
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 125)
                                .clipShape(CustomCorners(corners: [.bottomLeft, .bottomRight], radius: 10))
                            
                            
                            Text("2")
                                . font(Font.custom("Spoqa Han Sans Neo", size: 24)
                                    .weight(.bold)
                                )
                                .foregroundColor(.black)
                                .padding(.top, 60)
                        }
                        Circle()
                            .frame(width: 60, height: 60)
                        
                        Spacer()
                    }
                }
                
                HStack{
                    Text("하위 랭킹")
                        .padding(.leading, 30)
                        .padding(.bottom, 30)
                        .bold()
                        .font(.system(size: 16))
                    
                    Spacer()
                }
            }
        }
        .background(Color.mcGray)
        .cornerRadius(30)
    }
}

// Rectangle 특정모서리만 둥글게
struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct DashedLine: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: width, y: 0))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
            .foregroundColor(Color.gray)
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
