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
                                .cornerRadius(10)
                            
                            Text("2")
                                .bold()
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                    }
                    VStack{
                        Spacer()
                        Circle()
                            .frame(width: 60, height: 60)
                        
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 150)
                                .cornerRadius(10)
                            
                            Text("1")
                                .bold()
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            
                           
                        }
                        
                    }
                    VStack{
                        Spacer()
                        Circle()
                            .frame(width: 60, height: 60)
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                            
                            Text("3")
                                .bold()
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            
                           
                        }
                        
                    }
                }
               
            }
           

            VStack{
                HStack{
                    VStack{
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 100)
                                
                            
                                .cornerRadius(10)
                            
                            Text("3")
                                .bold()
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            
                           
                        }
                        
                        Circle()
                            .frame(width: 60, height: 60)
                        
                        Spacer()
                        
                    }
                    VStack{
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 150)
                                .cornerRadius(10)
                            
                            Text("1")
                                .bold()
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            
                           
                        }
                        
                        Circle()
                            .frame(width: 60, height: 60)
                        
                        Spacer()
                        
                    }
                    VStack{
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 125)
                                .cornerRadius(10)
                            
                            Text("2")
                                .bold()
                                .font(.system(size: 24))
                                .foregroundColor(.white)
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
        .background(Color(UIColor(hex: "#1C1C1D")))
        .cornerRadius(30)
        
        
        // List 순위
        VStack{
            Text("Dddadfadfadfadsfa")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
        .cornerRadius(30)
        
    }
}

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView()
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}
