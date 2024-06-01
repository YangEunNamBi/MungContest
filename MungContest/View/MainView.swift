//
//  MainView.swift
//  MungContest
//
//  Created by Woowon Kang on 6/1/24.
//

import SwiftUI


struct MainView: View {
    
    @Environment(NavigationManager.self) var navigationManager
    
    @State private var selectedSegment = 0
    private let segments = ["chart.bar.fill", "tablecells.badge.ellipsis"]
    
    
    var body: some View {
        VStack{
            HStack{
                Text("MUNG-CON")
                    .font(.system(size: 28))
                    .foregroundColor(Color(UIColor(hex: "#FFF7AB")))
                    .bold()
                    
                Spacer()
                HStack{
                    Picker("SegmentControl", selection: $selectedSegment) {
                        ForEach(0..<segments.count) { index in
                            Image(systemName: self.segments[index]).tag(index)
                            
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .frame(height: 50)
                    
                    if selectedSegment == 0 {
                        //BView()
                    } else {
                        //CView()
                    }
                }
                .frame(width: 200)
            }
            HStack{
                Text("원의 멍때리기 대회 ")
                    .font(.system(size: 28))
                    .bold()
                Spacer()
                
            }
            Spacer()
           
        }
        .padding(.horizontal, 50)
        .padding(.top, 64)
        
        
        
    }
}

// BView 정의
struct BView: View {
    var body: some View {
        Text("B View")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

// CView 정의
struct CView: View {
    var body: some View {
        Text("C View")
            .font(.largeTitle)
            .foregroundColor(.green)
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hexString).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexString.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8 * 1 & 0xF) * 17, (int >> 8 * 0 & 0xF) * 17, (int >> 8 * 2 & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24 & 0xFF, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(NavigationManager())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
