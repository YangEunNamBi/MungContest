//
//  NavigationManager.swift
//  MungContest
//
//  Created by Woowon Kang on 6/1/24.
//

import SwiftUI

enum PathType: Hashable {
    case splash
    case plan
    case standby
    case main
    case finish
}

extension PathType {
    @ViewBuilder
    func NavigatingView() -> some View {
        switch self {
        case .splash:
            SplashView()
            
        case .main:
            MainView()
            
        case .plan:
            PlanView()
            
        case .standby:
            StandbyView()
            
        case .finish:
            FinishView()
        }
    }
}

@Observable
class NavigationManager {
    var path: [PathType]
    init(
        path: [PathType] = []
    ){
        self.path = path
    }
}

extension NavigationManager {
    func push(to pathType: PathType) {
        path.append(pathType)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func pop(to pathType: PathType) {
        guard let lastIndex = path.lastIndex(of: pathType) else { return }
        path.removeLast(path.count - (lastIndex + 1))
    }
}

