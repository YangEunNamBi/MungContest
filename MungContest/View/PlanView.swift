//
//  PlanView.swift
//  MungContest
//
//  Created by Woowon Kang on 6/1/24.
//

import SwiftUI

struct PlanView: View {
    @Environment(NavigationManager.self) var navigationManager
    @State private var title: String = UserDefaults.standard.contestTitle
    @State private var measurementCount: Int = UserDefaults.standard.integer(forKey: "measurementCount")
    @State private var isRandom: Bool = UserDefaults.standard.bool(forKey: "isRandom")
    
    var body: some View {
        VStack {
            TextField("대회 제목을 입력해주세요", text: $title)
                .font(.system(size: 28))
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.mcGray800)
                )
                .padding(.horizontal, 50)
            
            HStack {
                Group {
                    VStack {
                        HStack {
                            Text("대회 시간")
                                .font(.system(size: 20))
                                .bold()
                                .padding(24)
                            Spacer()
                        }
                        Spacer()
                        
                    }
                    .frame(width: 338, height: 360)
                            .background(Color.mcGray800)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal, 20)
                    
                    VStack {
                        HStack {
                            Text("측정 횟수")
                                .font(.system(size: 20))
                                .bold()
                                .padding(24)
                            Spacer()
                        }
                        ZStack {
                            VStack {
                                Button {
                                    incrementCount()
                                } label: {
                                    Image(systemName: "chevron.up")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 48)
                                }
                                
                                Spacer()
                                
                                Button {
                                    decrementCount()
                                } label: {
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 48)
                                }
                            }
                            .padding(.bottom, 74)
                            
                            Text("\(measurementCount)")
                                .font(.system(size: 128))
                                .padding(.bottom, 74)
                        }
                        
                        Spacer()
                    }
                    .frame(width: 338, height: 360)
                            .background(Color.mcGray800)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal, 20)
                    
                    VStack {
                        HStack {
                            Text("랜덤 여부")
                                .font(.system(size: 20))
                                .bold()
                                .padding(.top, 24)
                                .padding(.leading, 24)
                            Spacer()
                        }
                        
                        VStack(alignment: .leading) {
                            Text("랜덤 여부를 ‘ON’으로 설정하면 측정\n시간을 불규칙하게 배정해줍니다.")
                                .lineSpacing(4)
                                
                        }
                        .font(.system(size: 16))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 16)
                        .background(Color.mcGray700)
                        .cornerRadius(12)
                        
                        HStack {
                            Button {
                                setRandom(true)
                            } label: {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 100, height: 100)
                                    .background(isRandom ? Color.accentColor : Color.mcGray700)
                                    .cornerRadius(12)
                                    .padding(.horizontal, 15)
                                    .overlay {
                                        Image(systemName: "circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50)
                                            .foregroundColor(isRandom ? .black : .white)
                                    }
                            }
                            
                            Button {
                                setRandom(false)
                            } label: {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 100, height: 100)
                                    .background(isRandom ? Color.mcGray700 : Color.accentColor)
                                    .cornerRadius(12)
                                    .padding(.horizontal, 15)
                                    .overlay {
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50)
                                            .foregroundColor(isRandom ? .white : .black)
                                    }
                            }
                        }
                        .padding(.top, 40)
                        
                        Spacer()
                    }
                    .frame(width: 338, height: 360)
                    .background(Color.mcGray800)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 40)
                
            }
            .padding(.horizontal, 10)
            
            VStack(alignment: .leading) {
                Text("참가자 파일 불러오기")
                HStack {
                    Text("구글 폼 불러오기")
                    Text("참가자 이미지 불러오기")
                }
            }
            
            //MARK: - 대기 화면으로
            Button {
                navigationManager.push(to: .standby)
            } label: {
                HStack {
                    Text("다음으로")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(Color.black)
                    
                    Image(systemName: "arrowtriangle.right.fill")
                        .resizable()
                        .foregroundColor(Color.black)
                        .frame(width: 22, height: 22)
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 30)
                .background(Color.accentColor)
                .cornerRadius(25)
                
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 50)
        }
    }
    
    //MARK: - 측정 횟수 함수
    private func incrementCount() {
        if measurementCount < 5 {
            measurementCount += 1
            saveCount()
        }
    }
    
    private func decrementCount() {
        if measurementCount > 1 {
            measurementCount -= 1
            saveCount()
        }
    }
    
    private func saveCount() {
        UserDefaults.standard.set(measurementCount, forKey: "measurementCount")
    }
    
    //MARK: - 랜덤 여부 함수
    private func setRandom(_ value: Bool) {
        isRandom = value
        UserDefaults.standard.set(isRandom, forKey: "isRandom")
    }
}

#Preview {
    PlanView()
        .environment(NavigationManager())
}
