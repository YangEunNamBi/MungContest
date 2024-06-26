//
//  CustomTFKeyboard.swift
//  MungContest
//
//  Created by 변준섭 on 6/2/24.
// 5분 19초

import SwiftUI

extension TextField{
    @ViewBuilder
    func inputView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View{
        self
            .background{
                SetTFKeyboard(keyboardContent: content())
            }
    }
}

fileprivate struct SetTFKeyboard<Content: View>: UIViewRepresentable {
    var keyboardContent: Content
    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if let textFieldContainerView = uiView.superview?.superview {
                if let textField = textFieldContainerView.findTextField{
                    ///Now with the help of UIHosting Controller converting swiftui view into UI KIt view
                    let hostingController = UIHostingController(rootView: keyboardContent)
                    hostingController.view.frame = .init(origin: .zero, size:hostingController.view.intrinsicContentSize)
                    /// Setting TF's Input View as our SwiftUI View
                    textField.inputView = hostingController.view
                } else{
                    print("Failed to find TF")
                }
                
            }
        }
    }
}

struct customTFKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
            .environment(NavigationManager())
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
/// 지금 첫 텍스트필드만 찾게 해놨는데, 이걸 모든 텍스트필드에 적용 가능하게 해야할듯?
fileprivate extension UIView{
    var allSubViews : [UIView] {
        return subviews.flatMap{ [$0] + $0.subviews}
    }
    var findTextField : UITextField? {
        if let textField = allSubViews.first(where: { view in
            view is UITextField
        })as? UITextField {
            return textField
        }
        return nil
    }
}
