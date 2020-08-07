import UIKit

struct Symbol: Codable {
    let id: Int
    let category: Categories
    let description: String
    let imageName: String
    var image: UIImage? {
        return UIImage(named: imageName)
    }
}
