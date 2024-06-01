import SwiftUI

struct StandbyView: View {
    @Environment(NavigationManager.self) var navigationManager
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var index = 0
    @State private var selectedNum: String = ""
    
    private let images: [String] = ["jen", "junyo", "mars", "won"]
    
    var body: some View {
        //                VStack {
        //                    Button("대회 메인 화면으로") {
        //                        navigationManager.push(to: .main)
        //                    }
        //                }
        TabView(selection: $selectedNum) {
            ForEach(images, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFit()
            }
        }
        .tabViewStyle(.page)
        .onReceive(timer, perform: { _ in
            withAnimation {
                index = (index + 1) % images.count
                selectedNum = images[index]
            }
        })
    }
}

struct StandbyView_Previews: PreviewProvider {
    static var previews: some View {
        StandbyView()
            .environment(NavigationManager())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
