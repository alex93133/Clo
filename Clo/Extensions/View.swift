import UIKit

extension UIView {

    func add<T: UIView>(view: T) {
        let childView = T(frame: UIScreen.main.bounds)
        addSubview(childView)
    }
}
