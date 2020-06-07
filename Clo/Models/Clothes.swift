import UIKit
import CoreData

struct Clothes {

    var type: ClothingType
    var color: ColorType
    var info: String?
    var photo: UIImage
    var symbols: [Symbol]
}

extension Clothes {

    init(typeString: String, colorString: String, info: String?, photoData: Data, symbolsIDs: [Int]) {

        let symbols = Symbols.allSymbols()
        let selectedSymbols = symbols!.filter { symbolsIDs.contains($0.id) }

        self.type    = ClothingType(rawValue: typeString)!
        self.color   = ColorType(rawValue: colorString)!
        self.photo   = UIImage(data: photoData)!
        self.symbols = selectedSymbols
    }
}
