import SwiftUI
import SwiftData

struct StandbyView: View {
    @Environment(NavigationManager.self) var navigationManager
    @Environment(\.modelContext) var modelContext
    
    @State private var title: String = UserDefaults.standard.contestTitle
    
    @State private var currentIndex: Int?
    
    private let images: [String] = ["junyo", "won", "jen", "hash", "mars"]
    
    @Query var players: [Player]
    
    @State private var itemsArray: [[Player]] = []
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let animationDuration: CGFloat = 0.3
    @State private var scrollViewProxy: ScrollViewProxy?
    
    @State private var isFullScreenPresented = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    
    var body: some View {
        var itemsTemp = itemsArray.flatMap { $0 }
        
        let today = dateFormatter.string(from: Date())
        
        VStack(spacing: 0){
            HStack(spacing: 30) {
                
                //MARK: - 대회 정보 상단바
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
                        Text("\(players.count)명")
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 20)
                    
                    Rectangle()
                        .frame(width: 1)
                        .foregroundColor(.mcGray700)
                    
                    VStack {
                        Text("\(title)")
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
                
                // MARK: - 새로운 참가자 추가 버튼
                Button(action: {
                    isFullScreenPresented.toggle()
                }, label: {
                    HStack{
                        Image(systemName: "person.crop.circle.badge.plus")
                    }
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(.accent)
                })
                .frame(width: 76, height: 76)
                .background(.mcGray800)
                .clipShape(Circle())
            }
            .padding(.bottom, 64)
            .fullScreenCover(isPresented: $isFullScreenPresented) {
                VStack(alignment: .center) {
                    AddPlayerView(isFullScreenPresented: $isFullScreenPresented)
                }
                .background(Color.clear)
            }
            
            //MARK: - 말풍선
            VStack(spacing: -8){
                if let index = currentIndex, !players.isEmpty{
                    /// images만 3배 늘리고 dummieData는 그대로 둬서 currentIndex를 dummieData에 적용할 수 없음
                    /// realIndex 임시로 넣어줌
                    let realIndex = index % players.count
                    
                    //TODO: 따옴표 변경
                    HStack(alignment: .top){
                        Image(systemName: "quote.opening")
                            .foregroundColor(.mcGray500)
                        
                        VStack(alignment: .leading, spacing: 6){
                            Text(players[realIndex].name)
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(.mcGray500)
                            
                            Text(players[realIndex].comment)
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                        }
                        
                        Image(systemName: "quote.closing")
                            .foregroundColor(.mcGray500)
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 16)
                    .background(.white)
                    .clipShape(Capsule())
                    
                    Text(Image(systemName: "triangle.fill"))
                        .font(.title2)
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(180))
                }
            }
            
            //MARK: - 참가자 이미지 스크롤
            ScrollView(.horizontal) {
                ScrollViewReader { proxy in
                    HStack(spacing: 0) {
                        ForEach(0..<itemsTemp.count, id: \.self) { i in
                            if let image = UIImage(data: players[i % players.count].profileImage){
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 260, height: 260)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle()
                                            .stroke(i == currentIndex ? Color.accent : Color.gray, lineWidth: 6)
                                            .stroke(i == currentIndex ? Color.accent.opacity(0.3) : Color.clear, lineWidth: i == currentIndex ? 25 : 0)
                                            .stroke(i == currentIndex ? Color.accent.opacity(0.2) : Color.clear, lineWidth: i == currentIndex ? 40 : 0)
                                    }
                                    .frame(width: 280, height: 321)
                            }
                        }
                    }
                    .onChange(of: currentIndex) {
                        guard let currentIndex = currentIndex else { return }
                        withAnimation {
                            proxy.scrollTo(currentIndex, anchor: .center)
                        }
                    }
                }
            }
            .scrollPosition(id: $currentIndex)
            .scrollIndicators(.hidden)
            .onAppear {
                self.itemsArray = [players, players, players]
                currentIndex = players.count
            }
            .onChange(of: currentIndex) {
                guard let currentIndex = currentIndex else {return}
                print(currentIndex)
                let itemCount = players.count
                
                // 마지막 배열의 첫번째일 때 (우측으로 스크롤)
                if currentIndex == itemCount * 2 {
                    print("마지막 배열의 첫번째다")
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        let removedElement = itemsTemp.removeFirst()
                        itemsTemp.append(removedElement)
                        print(itemsTemp)
                        self.currentIndex = currentIndex - itemCount
                    }
                }
            }
            .onReceive(timer) { _ in
                guard let currentIndex = currentIndex else { return }
                let itemCount = players.count
                let newIndex = (currentIndex + 1) % (itemCount * 3)
                self.currentIndex = newIndex
            }
            
            //MARK: - 심박수 입력 버튼
            Button(action: {
                navigationManager.push(to: .main)
            }, label: {
                HStack{
                    Text("대회 시작하기")
                    Image(systemName: "arrowtriangle.right.fill")
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
