import UIKit

struct Router {

    static func signIn(from vc: UIViewController) {
        DispatchQueue.main.async {
            let listOfClothesViewController = ListOfClothesViewController()
            listOfClothesViewController.modalPresentationStyle = .fullScreen
            vc.present(listOfClothesViewController, animated: true, completion: nil)
        }
    }
}
