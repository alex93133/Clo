import UIKit

struct ClothingColor {

    let type: ColorType
    let image: UIImage

    static func getAllClothingColors() -> [ClothingColor] {
        let black = ClothingColor(type: .black, image: Images.ColorType.black!)
        let color = ClothingColor(type: .color, image: Images.ColorType.color!)
        let white = ClothingColor(type: .white, image: Images.ColorType.white!)
        return [color, black, white]
    }
}

enum ColorType: String {
    case black = "Black"
    case color = "Color"
    case white = "White"
}
