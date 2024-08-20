import Foundation
import SwiftData

@Model
class Player {
    
    @Attribute(.unique) var id = UUID()
    var name: String
    @Attribute(.externalStorage) var profileImage: Data
    var comment: String
    
    var defaultHeartrate: Int
    var heartrates: [Int]
    var differenceHeartrates: [Int]
    var resultHeartrate: Int
    
    init(name: String, profileImage: Data, comment: String, defaultHeartrate: Int, heartrates: [Int], differenceHeartrates: [Int], resultHeartrate: Int) {
        self.name = name
        self.profileImage = profileImage
        self.comment = comment
        self.defaultHeartrate = defaultHeartrate
        self.heartrates = heartrates
        self.differenceHeartrates = differenceHeartrates
        self.resultHeartrate = resultHeartrate
    }
}
