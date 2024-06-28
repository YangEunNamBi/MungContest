import SwiftUI

struct StandbyView: View {
    @Environment(NavigationManager.self) var navigationManager
    @Environment(\.modelContext) var modelContext
    @State private var title: String = UserDefaults.standard.contestTitle
    
    @State private var currentIndex: Int?
    
    private let images: [String] = ["jen", "junyo", "mars", "won", "hash"]
    var dummieData : [Player] = [
        Player(name: "준요", profileImage: Data(), comment: "내가 젠은 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0),
        Player(name: "원", profileImage: Data(), comment: "내가 준요는 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0),
        Player(name: "젠", profileImage: Data(), comment: "내가 원은 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0),
        Player(name: "해시", profileImage: Data(), comment: "내가 젠은 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0),
        Player(name: "마스", profileImage: Data(), comment: "내가 해시는 이긴다 ㅋㅋ", defaultHeartrate: 0, heartrates: [0, 0, 0, 0], differenceHeartrates: [0, 0, 0, 0], resultHeartrate: 0)
    ]
    
    @State private var itemsArray: [[Player]] = []
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let animationDuration: CGFloat = 0.3
    @State private var scrollViewProxy: ScrollViewProxy?
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()

    var body: some View {
        let itemsTemp = itemsArray.flatMap { $0 }
        
        let today = dateFormatter.string(from: Date())
        
        //                VStack {
        //                    Button("대회 메인 화면으로") {
        //                        navigationManager.push(to: .main)
        //                    }
        //                }
        VStack{
            HStack(spacing: 0){
                HStack(spacing: 12){
                    Text("\(Image(systemName: "calendar"))")
                        .foregroundStyle(.accent)
                    Text("\(today)")
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                
                Rectangle()
                    .frame(width: 1)
                    .foregroundColor(.mcGray700)
                
                HStack(spacing: 12){
                    Text("\(Image(systemName: "person.crop.circle"))")
                        .foregroundStyle(.accent)
                    Text("30명")
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                
                Rectangle()
                    .frame(width: 1)
                    .foregroundColor(.mcGray700)
                
                VStack {
                    //                Text("\(title)")
                    Text("원의 멍때리기 대회")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                
            }
            .font(.system(size: 28))
            .fontWeight(.medium)
            .frame(width: 978, height: 76)
            .background(.mcGray800)
            .clipShape(Capsule())
            .padding(.bottom, 64)
            
            ScrollView(.horizontal) {
                ScrollViewReader { proxy in
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(0..<itemsTemp.count, id: \.self) { i in
                            VStack{
                                Image(images[i % images.count])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 260, height: 260)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle()
                                            .stroke(i == currentIndex ? Color.accent : Color.gray, lineWidth: 10)
                                    }
                                    .border(.white)
                            }
                            .frame(width: 280, height: 280)
                            .border(.white)
                        }
                    }
                }
            }
            .scrollPosition(id: $currentIndex)
            .scrollIndicators(.hidden)
            .onAppear {
                self.itemsArray = [dummieData, dummieData, dummieData]
                currentIndex = dummieData.count
            }
            .onChange(of: currentIndex) {
                guard let currentIndex = currentIndex else {return}
                print(currentIndex)
                let itemCount = dummieData.count
                
                // 첫번째 배열의 마지막일 때 (좌측으로 스크롤)
                if currentIndex < itemCount  {
                    print("첫번째 배열의 마지막이다")
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        itemsArray.removeLast()
                        itemsArray.insert(dummieData, at: 0)
                        self.currentIndex = currentIndex + itemCount
                    }
                }
                
                // 마지막 배열의 첫번째일 때 (우측으로 스크롤)
                if currentIndex >= itemCount * 2 {
                    print("마지막 배열의 첫번째다")
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        itemsArray.removeFirst()
                        itemsArray.append(dummieData)
                        self.currentIndex = currentIndex - itemCount
                    }
                }
            }
            .onReceive(timer) { _ in
                          guard let currentIndex = currentIndex else { return }
                          let itemCount = dummieData.count
                          let newIndex = (currentIndex + 1) % (itemCount * 3)
                          self.currentIndex = newIndex
                      }
            
            Button(action: {
            }, label: {
                HStack{
                    Text("심박수 입력하기")
                    Image(systemName: "pencil")
                }
                .font(.system(size: 24))
                .bold()
                .fontWeight(.bold)
                .foregroundColor(.black)
            })
            .padding(.horizontal, 30)
            .padding(.vertical, 14)
            .background(.accent)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(.pink, lineWidth: 1)
            )
            .padding(.top, 50)
        }
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
