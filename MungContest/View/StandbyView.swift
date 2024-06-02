import SwiftUI

struct StandbyView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    
    private let images: [String] = ["jen", "junyo", "mars", "won"]
    @State var dummieData : [Player] = [
        Player(name: "준요", profileImage: Data(), comment: "내가 젠은 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0),
        Player(name: "원", profileImage: Data(), comment: "내가 준요는 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0),
        Player(name: "젠", profileImage: Data(), comment: "내가 원은 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0),
        Player(name: "해시", profileImage: Data(), comment: "내가 젠은 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0),
        Player(name: "마스", profileImage: Data(), comment: "내가 해시는 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0)
    ]
    
    var body: some View {
        //                VStack {
        //                    Button("대회 메인 화면으로") {
        //                        navigationManager.push(to: .main)
        //                    }
        //                }
        ScrollViewReader { scrollProxy in // needed to scroll programmatically
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(0..<dummieData.count, id: \.self) { i in
                        VStack{
                            Image(images[i % images.count])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 400, height: 400)
                                .clipShape(RoundedRectangle(cornerRadius: 260))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 260)
                                        .stroke(.yellow, lineWidth: 6)
                                }
                        }
                    }
                }
                .onReceive(timer) { _ in
                    currentIndex = currentIndex < dummieData.count - 1 ? currentIndex + 1 : 0
                    withAnimation {
                        scrollProxy.scrollTo(currentIndex, anchor: .center) // scroll to next .id
                    }
                }
            }
        }}
}

struct StandbyView_Previews: PreviewProvider {
    static var previews: some View {
        StandbyView()
            .environment(NavigationManager())
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}
