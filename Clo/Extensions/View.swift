import UIKit

extension UIView {
    func addBorder(width: CGFloat = 0.5, color: UIColor = Colors.border) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
