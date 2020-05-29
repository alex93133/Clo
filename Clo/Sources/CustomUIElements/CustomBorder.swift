import UIKit

struct CustomBorder {

    static func createDefaultBorder(target layer: CALayer) {
        layer.borderWidth = 0.5
        layer.borderColor = Colors.separator.cgColor
    }
}
