//
//  UserDefaults+.swift
//  MungContest
//
//  Created by Woowon Kang on 6/2/24.
//

import Foundation

extension UserDefaults {
    var contestTitle: String {
        get { string(forKey: "contestTitle") ?? "" }
        set { set(newValue, forKey: "contestTitle") }
    }
}
