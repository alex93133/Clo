import UIKit

struct ClothingColor {

    let type: ColorType
    let image: UIImage

    static func getAllClothingColors() -> [ClothingColor] {
        let color = ClothingColor(type: .color, image: Images.ColorType.color!)
        let black = ClothingColor(type: .black, image: Images.ColorType.black!)
        let white = ClothingColor(type: .white, image: Images.ColorType.white!)
        return [color, black, white]
    }
}

enum ColorType {
    case color
    case black
    case white
}
