//
//  AddPlayerView.swift
//  MungContest
//
//  Created by Hyun Jaeyeon on 8/16/24.
//

import SwiftUI

struct AddPlayerView: View {
    @Environment(\.modelContext) var modelContext
    @State private var name: String = ""
    @State private var comment: String = ""
    @State private var image: Data = Data()
    
    @State private var isShowingFileImage = false
    @State private var selectedImageURL: URL?
    
    @State private var player: Player?
    @Binding var isFullScreenPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            //MARK: - 이름
            Group{
                Text("이름")
                    .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                    .foregroundColor(.accent)
                
                TextField("이름을 입력해주세요", text: $name)
                    .font(.custom("SpoqaHanSansNeo-Medium", size: 28))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.mcGray700)
                    )
                    .padding(.bottom)
            }
            
            //MARK: - 각오
            Group{
                Text("각오")
                    .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                    .foregroundColor(.accent)
                
                TextField("각오를 입력해주세요", text: $comment, axis: .vertical)
                    .multilineTextAlignment(.leading)
                    .font(.custom("SpoqaHanSansNeo-Medium", size: 28))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                    .frame(minHeight: 120, alignment: .top)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.mcGray700)
                    )
                    .padding(.bottom)
            }
            
            //MARK: - 이미지
            Group{
                Text("이미지")
                    .font(.custom("SpoqaHanSansNeo-Bold", size: 20))
                    .foregroundColor(.accent)
                
                Button(action: {
                    requestFileAccessPermission()
                    isShowingFileImage.toggle()
                }) {
                    HStack(spacing: 18){
                        Text((selectedImageURL != nil) ? "이미지 불러오기 완료" : "이미지 불러오기")
                            .font(.custom("SpoqaHanSansNeo-Bold", size: 24))
                        
                        Image(systemName: (selectedImageURL != nil) ? "xmark" : "square.and.arrow.down")
                            .font(.system(size: 20, weight: .bold))
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical)
                    .background(Color.mcGray700)
                    .foregroundColor((selectedImageURL != nil) ? Color.accentColor : Color.mcGray300)
                    .cornerRadius(16)
                }
                .padding(.bottom, 12)
                .fileImporter(
                    isPresented: $isShowingFileImage,
                    allowedContentTypes: [.image],
                    allowsMultipleSelection: false
                ) { result in
                    switch result {
                    case .success(let urls):
                        selectedImageURL = urls.first
                        loadImages()
                    case .failure(let error):
                        print("Failed to import files: \(error.localizedDescription)")
                    }
                }
            }
            
            //MARK: - 등록
            HStack{
                Spacer()
                Button(action: {
                    addNewPlayer()
                    isFullScreenPresented.toggle()
                }, label: {
                    HStack{
                        Text("등록")
                    }
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                })
                .padding(.horizontal, 30)
                .padding(.vertical, 14)
                .background(.accent)
                .clipShape(Capsule())
            }
        }
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.mcGray800)
        )
        .frame(width: 542)
    }
    
    ///새로운 player을 SwiftData에 저장하는 함수
    func addNewPlayer() {
        guard !name.isEmpty, !comment.isEmpty, !image.isEmpty else {
            print("플레이어 정보를 등록하세요!!!!!!")
            return
        }
        
        let newPlayer = Player(
            name: name,
            profileImage: image,
            comment: comment,
            defaultHeartrate: 0,
            heartrates: [],
            differenceHeartrates: [],
            resultHeartrate: 0
        )
        
        do {
            modelContext.insert(newPlayer)
            try modelContext.save()
        } catch {
            print("Failed to save player: \(error.localizedDescription)")
        }
    }
    
    ///파일 액세스 관련 함수
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
    
    ///url로 된 이미지를 player 정보에 넣는 함수
    func loadImages() {
        if let imageURL = selectedImageURL {
            guard imageURL.startAccessingSecurityScopedResource() else {
                return
            }
            
            defer { imageURL.stopAccessingSecurityScopedResource() }
            
            guard let imageData = try? Data(contentsOf: imageURL) else {
                print("Failed to load image data from URL: \(imageURL)")
                
                return
            }
            
            let playerName = imageURL.lastPathComponent.split(separator: ".").dropLast().joined(separator: ".")

            
            image = imageData
        }
    }
}

#Preview {
    AddPlayerView(isFullScreenPresented: .constant(true))
}
