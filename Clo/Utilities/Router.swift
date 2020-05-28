import UIKit

struct Router {

    static func signIn(from viewController: UIViewController) {
        DispatchQueue.main.async {
            let listOfClothesViewController = TabBarController()
            listOfClothesViewController.modalPresentationStyle = .fullScreen
            viewController.present(listOfClothesViewController, animated: true, completion: nil)
        }
    }
}
