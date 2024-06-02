import SwiftUI

struct StandbyView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    
    private let images: [String] = ["jen", "junyo", "mars", "won", "hash"]
    @State var dummieData : [Player] = [
        Player(name: "준요", profileImage: Data(), comment: "내가 젠은 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0),
        Player(name: "원", profileImage: Data(), comment: "내가 준요는 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0),
        Player(name: "젠", profileImage: Data(), comment: "내가 원은 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0),
        Player(name: "해시", profileImage: Data(), comment: "내가 젠은 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0),
        Player(name: "마스", profileImage: Data(), comment: "내가 해시는 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0)
    ]
    
    static let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    
    var today = Date()
    
    var body: some View {
        
        //                VStack {
        //                    Button("대회 메인 화면으로") {
        //                        navigationManager.push(to: .main)
        //                    }
        //                }
        VStack{
            Text("\(today)")
                .font(.largeTitle)
                .fontWeight(.medium)
                .frame(width: 978, height: 76)
                .background(.gray)
                .clipShape(Capsule())
                .padding(.bottom, 64)
            
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(0..<dummieData.count, id: \.self) { i in
                            GeometryReader { geometry in
                                let scale = getScale(proxy: geometry)
                                VStack{
                                    Image(images[i % images.count])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 260 * scale, height: 260 * scale)
                                        .clipShape(Circle())
                                        .overlay {
                                            Circle()
                                                .stroke(i == currentIndex ? Color.yellow : Color.gray, lineWidth: 10 * scale)
                                        }
                                        .border(.white)
                                }
                                .frame(width: 280, height: 280)
                                .border(.white)
                            }
                        }
                        .frame(width: 280, height: 280)
                    }
                    .onReceive(timer) { _ in
                        currentIndex = currentIndex < dummieData.count - 1 ? currentIndex + 1 : 0
                        withAnimation {
                            scrollProxy.scrollTo(currentIndex, anchor: .center) // scroll to next .id
                        }
                    }
                }
            }
            
            Button(action: {
            }, label: {
                Text("심박수 입력하기")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 14)
                    .background(.yellow)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(.pink, lineWidth: 1)
                    )
            })
            .padding(.top, 50)
        }
    }
    //MARK: 스케일 설정 함수
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = 200
        let viewFrame = proxy.frame(in: .global)
        let distanceFromCenter = abs(viewFrame.midX - UIScreen.main.bounds.width / 2)
        let minScale: CGFloat = 0.76
        let maxScale: CGFloat = 1.0
        
        return max(maxScale - (distanceFromCenter / midPoint) * (maxScale - minScale), minScale)
    }
}

struct StandbyView_Previews: PreviewProvider {
    static var previews: some View {
        StandbyView()
            .environment(NavigationManager())
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}
