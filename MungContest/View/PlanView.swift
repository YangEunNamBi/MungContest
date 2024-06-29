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
                .font(.custom("SpoqaHanSansNeo-Medium", size: 28))
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
                                .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
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
                                .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                                .bold()
                                .padding(24)
                            Spacer()
                        }
                        Spacer()
                        
                        .overlay{
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
                                .disabled(measurementCount >= 5)
                                .padding()
                                Spacer()
                                        .frame(height: 128)
                                
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
                                .padding()
                                .padding(.bottom, 20)
                                
                            }
                            
                            Text("\(measurementCount)")
                                .font(.custom("Poppins-Regular", size: 128))
                                .padding(.bottom, 20)
                        }
                    }
                    .frame(width: 338, height: 360)
                    .background(Color.mcGray800)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)
                    
                    VStack {
                        HStack {
                            Text("랜덤 여부")
                                .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                                .padding(.top, 24)
                                .padding(.leading, 24)
                            Spacer()
                        }
                        
                        VStack(alignment: .leading) {
                            Text("랜덤 여부를 ‘ON’으로 설정하면 측정\n시간을 불규칙하게 배정해줍니다.")
                                .font(.custom("SpoqaHanSansNeo-Regular", size: 16))
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
                                        Text("O")
                                            .font(.custom("Poppins-Regular", size: 64))
                                            .foregroundColor(isRandom ? .black : .mcGray300)
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
                                        Text("X")
                                            .font(.custom("Poppins-Regular", size: 64))
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
                        .font(.custom("SpoqaHanSansNeo-Medium", size: 16))
                        .padding(.horizontal, 12)
                    HStack {
                        Button(action: {
                            requestFileAccessPermission()
                            isShowingFilePicker.toggle()
                        }) {
                            HStack {
                                Spacer().frame(width: 12)
                                
                                Text(canLoadFiles() ? "\(players.count)명의 참가자 명단 불러오기 완료" : "참가자 명단 불러오기")
                                    .font(.custom("SpoqaHanSansNeo-Medium", size: 24))
                                    .padding(.vertical, 12)
                                    
                                Spacer().frame(width: 18)
                                
                                Image(systemName: canLoadFiles() ? "xmark" : "square.and.arrow.down")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .bold()
                                    .frame(width: 18)
                                    .padding(.vertical, 12)
                                
                                Spacer().frame(width: 12)
                            }
                            .padding(.horizontal, 12)
                            .background(Color.mcGray800)
                            .foregroundColor(canLoadFiles() ? Color.accentColor : Color.mcGray300)
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
                            requestFileAccessPermission()
                            isShowingFileImage.toggle()
                        }) {
                            HStack {
                                Spacer().frame(width: 12)
                                
                                Text(canLoadImages() ? "\(players.count)명의 참가자 불러오기 완료" : "참가자 이미지 불러오기")
                                    .font(.custom("SpoqaHanSansNeo-Medium", size: 24))
                                    .padding(.vertical, 12)
                                
                                Spacer().frame(width: 18)
                                
                                Image(systemName: canLoadImages() ? "xmark" : "square.and.arrow.down")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .bold()
                                    .frame(width: 18)
                                    .padding(.vertical, 12)
                                
                                Spacer().frame(width: 12)
                            }
                            .padding(.horizontal, 12)
                            .background(Color.mcGray800)
                            .foregroundColor(canLoadImages() ? Color.accentColor : Color.mcGray300)
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
                        
                    }
                    .foregroundStyle(Color.accentColor)
                    .frame(height: 50)
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
        guard url.startAccessingSecurityScopedResource() else {
            return
        }
        
        defer { url.stopAccessingSecurityScopedResource() }
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
            guard imageURL.startAccessingSecurityScopedResource() else {
                return
            }
            
            defer { imageURL.stopAccessingSecurityScopedResource() }
            
            guard let imageData = try? Data(contentsOf: imageURL) else {
                print("Failed to load image data from URL: \(imageURL)")
                continue
            }
            
            let playerName = imageURL.lastPathComponent.split(separator: ".").dropLast().joined(separator: ".")

            if let existingPlayer = players.first(where: { $0.name == playerName }) {
                existingPlayer.profileImage = imageData
                savePlayer(existingPlayer)
            } else {
                print("No player found with name: \(playerName)")
            }
        }
    }

    
    func canLoadImages() -> Bool {
        for player in players {
            if player.profileImage.isEmpty || player.name.isEmpty {
                return false
                print("둘 중 하나 없음")
            }
        }
        return !players.isEmpty
    }
    
    func canLoadFiles() -> Bool {
        for player in players {
            if player.name.isEmpty {
                return false
            }
        }
        return !players.isEmpty
    }
    
    func requestFileAccessPermission() {
        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("문서 디렉토리를 찾을 수 없습니다.")
            return
        }
        
        do {
            try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            print("파일 액세스 권한이 허용되었습니다.")
        } catch {
            print("파일 액세스 권한을 요청합니다.")
        }
    }
    
}

#Preview {
    PlanView()
        .environment(NavigationManager())
}
