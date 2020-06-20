import CoreData
import UIKit

struct Clothes {
    let uID: String
    var type: ClothingType
    var color: ColorType
    var info: String?
    var photo: UIImage
    var symbols: [Symbol]
}

extension Clothes {
    init(uID: String, typeString: String, colorString: String, info: String?, photoData: Data, symbolsIDs: [Int]) {
        let symbols         = Symbols.allSymbols()
        let selectedSymbols = symbols!.filter { symbolsIDs.contains($0.id) }
        self.uID            = uID
        type                = ClothingType(rawValue: typeString)!
        color               = ColorType(rawValue: colorString)!
        photo               = UIImage(data: photoData)!
        self.symbols        = selectedSymbols

        if let infoText = info {
            self.info = infoText
        }
    }
}
