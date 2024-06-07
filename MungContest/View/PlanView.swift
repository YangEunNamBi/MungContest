//
//  PlanView.swift
//  MungContest
//
//  Created by Woowon Kang on 6/1/24.
//

import SwiftUI

struct PlanView: View {
    @Environment(NavigationManager.self) var navigationManager
    @Environment(\.modelContext) var modelContext
    @State private var title: String = UserDefaults.standard.contestTitle
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State private var measurementCount: Int = {
        let count = UserDefaults.standard.integer(forKey: "measurementCount")
        return count == 0 ? 1 : count
    }()
    @State private var isRandom: Bool = UserDefaults.standard.bool(forKey: "isRandom")
    
    @State private var isShowingFilePicker = false
    @State private var isShowingFileImage = false
    @State private var selectedImageURLs: [URL] = []
    
    @State private var players: [Player] = []
    
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
                        HStack {
                            Picker("", selection: $hours){
                                ForEach(0..<24, id: \.self) { i in
                                    Text("\(i) 시간").tag(i)
                                }
                            }.pickerStyle(.wheel)
                            Picker("", selection: $minutes){
                                ForEach(0..<60, id: \.self) { i in
                                    Text("\(i) 분").tag(i)
                                }
                            }.pickerStyle(.wheel)
                        }.padding(.horizontal)
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
                                        .foregroundColor(measurementCount >= 5 ? Color.mcGray500 : Color.accentColor)
                                }
                                .padding(.bottom, 20)
                                .disabled(measurementCount >= 5)
                                
                                Spacer()
                                
                                Button {
                                    decrementCount()
                                } label: {
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 48)
                                        .foregroundColor(measurementCount <= 1 ? Color.mcGray500 : Color.accentColor)
                                }
                                .disabled(measurementCount <= 1)
                            }
                            .padding(.bottom, 64)
                            
                            Text("\(measurementCount)")
                                .font(.system(size: 128))
                                .padding(.bottom, 64)
                        }
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
            
            HStack {
                VStack(alignment: .leading) {
                    Text("참가자 파일 불러오기")
                        .padding(.horizontal, 12)
                    HStack {
                        Button(action: {
                            isShowingFilePicker.toggle()
                        }) {
                            HStack {
                                Spacer().frame(width: 12)
                                
                                Text("구글 폼 불러오기")
                                    .font(.system(size: 24))
                                    .padding(.vertical, 12)
                                
                                Spacer().frame(width: 18)
                                
                                Image(systemName: "square.and.arrow.down")
                                    .resizable()
                                    .bold()
                                    .scaledToFit()
                                    .frame(width: 18)
                                    .padding(.vertical, 12)
                                
                                Spacer().frame(width: 12)
                            }
                            .padding(.horizontal, 12)
                            .background(Color.mcGray800)
                            .cornerRadius(40)
                            .padding(.horizontal, 10)
                        }
                        .fileImporter(
                            isPresented: $isShowingFilePicker,
                            allowedContentTypes: [.commaSeparatedText],
                            allowsMultipleSelection: false
                        ) { result in
                            switch result {
                            case .success(let urls):
                                if let url = urls.first {
                                    importCSVFile(url: url)
                                }
                            case .failure(let error):
                                print("Failed to import file: \(error.localizedDescription)")
                            }
                        }
                        
                        Button(action: {
                            isShowingFileImage.toggle()
                            
                        }) {
                            HStack {
                                Spacer().frame(width: 12)
                                
                                Text("참가자 이미지 불러오기")
                                    .font(.system(size: 24))
                                    .padding(.vertical, 12)
                                
                                Spacer().frame(width: 18)
                                
                                Image(systemName: "square.and.arrow.down")
                                    .resizable()
                                    .bold()
                                    .scaledToFit()
                                    .frame(width: 18)
                                    .padding(.vertical, 12)
                                
                                Spacer().frame(width: 12)
                            }
                            .padding(.horizontal, 12)
                            .background(Color.mcGray800)
                            .cornerRadius(40)
                            .padding(.horizontal, 10)
                        }
                        .fileImporter(
                            isPresented: $isShowingFileImage,
                            allowedContentTypes: [.image],
                            allowsMultipleSelection: true
                        ) { result in
                            switch result {
                                case .success(let urls):
                                    selectedImageURLs = urls
                                    loadImages()
                                case .failure(let error):
                                    print("Failed to import files: \(error.localizedDescription)")
                                }
                        }
                        
                        List(players, id: \.id) { player in
                            VStack {
                                if let uiImage = UIImage(data: player.profileImage) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .padding(.trailing, 10)
                                }
                                VStack(alignment: .leading) {
                                    Text(player.name)
                                        .font(.headline)
                                    Text(player.comment)
                                        .font(.subheadline)
                                }
                            }
                        }
                        
                    }
                    .foregroundStyle(Color.accentColor)
                }
                .padding(.horizontal, 38)
                Spacer()
            }
            .padding(.bottom, 24)
            
            //MARK: - 대기 화면으로
            HStack {
                Spacer()
                
                Button {
                    saveTime(hours: hours, minutes: minutes)
                    print("\(hours), \(minutes),")
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
                .padding(.horizontal, 12)
            }
            .padding(.horizontal, 38)
        }
    }
    
    //MARK: - 대회 시간 저장
    private func saveTime(hours: Int, minutes: Int) {
        UserDefaults.standard.set(hours, forKey: "selectedHours")
        UserDefaults.standard.set(minutes, forKey: "selectedMinutes")
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
    
    
    //MARK: - CSV 파싱
    
    func importCSVFile(url: URL) {
        do {
            let fileContent = try String(contentsOf: url)
            parseCSV(fileContent: fileContent)
        } catch {
            print("Failed to read file content: \(error.localizedDescription)")
        }
    }
    
    func parseCSV(fileContent: String) {
        let rows = fileContent.components(separatedBy: "\n")
        for (index, row) in rows.enumerated() {
            // Skip the header row
            if index == 0 { continue }
            
            let columns = row.split(separator: ",", omittingEmptySubsequences: false).map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            if columns.count >= 4 {
                let name = columns[1]
                let comment = columns[2]
                
                print("Parsed Player: \(name), \(comment)")
                
                let player = Player(name: name, profileImage: Data(), comment: comment, defaultHeartrate: 0, heartrates: [], differenceHeartrates: [], resultHeartrate: 0)
                DispatchQueue.main.async {
                    players.append(player)
                }
            } else {
                print("Skipping row: \(row)")
            }
        }
    }
    
    func savePlayer(_ player: Player) {
        do {
            try modelContext.insert(player)
            try modelContext.save()
        } catch {
            print("Failed to save player: \(error.localizedDescription)")
        }
    }
    
    //MARK: - 이미지 불러오기
    func loadImages() {
        for imageURL in selectedImageURLs {
            guard let imageData = try? Data(contentsOf: imageURL) else {
                print("Failed to load image data from URL: \(imageURL)")
                continue
            }
            let playerName = imageURL.lastPathComponent.replacingOccurrences(of: ".jpeg", with: "")
            
            // 가져온 플레이어 이름으로 모델을 만듭니다.
            let player = Player(name: playerName, profileImage: imageData, comment: "", defaultHeartrate: 0, heartrates: [], differenceHeartrates: [], resultHeartrate: 0)
            
            // 생성된 플레이어를 리스트에 추가합니다.
            players.append(player)
        }
    }


}

#Preview {
    PlanView()
        .environment(NavigationManager())
}
