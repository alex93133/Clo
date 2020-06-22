import UIKit

extension UIImageView {
    func rotate() {
        let rotation          = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue      = NSNumber(value: Double.pi * 2)
        rotation.duration     = Constants.animationTimeInterval
        rotation.isCumulative = true
        rotation.repeatCount  = 1
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
