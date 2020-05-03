import UIKit

extension UIViewController {

    func addChildViewController(add child: UIViewController, target parent: UIViewController) {
        parent.addChild(child)
        parent.view.addSubview(child.view)
        child.didMove(toParent: parent)
    }
}
