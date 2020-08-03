import CoreData
import UIKit

struct Clothes {
    let creationDate: Date
    var type: ClothingType
    var color: ColorType
    var info: String?
    var photo: UIImage
    var symbols: [Symbol]
}

extension Clothes {
    init(creationDate: Date, typeString: String, colorString: String, info: String?, photoData: Data, symbolsIDs: [Int]) {
        let symbols         = Symbols.allSymbols()
        let selectedSymbols = symbols!.filter { symbolsIDs.contains($0.id) }
        self.creationDate   = creationDate
        type                = ClothingType(rawValue: typeString)!
        color               = ColorType(rawValue: colorString)!
        photo               = UIImage(data: photoData)!
        self.symbols        = selectedSymbols

        if let infoText = info {
            self.info = infoText
        }
    }
}
