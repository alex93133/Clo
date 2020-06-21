import UIKit

extension UICollectionViewCell {
    func animate() {
        UIView.animate(withDuration: Constants.animationTimeInterval,
                       delay: 0,
                       options: [.allowUserInteraction],
                       animations: { [weak self] in
                        guard let self = self else { return }
                        let transform: CGAffineTransform = self.isHighlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
                        self.transform = transform
            }, completion: nil)
    }
}
