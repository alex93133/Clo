import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTabs()
    }

    // MARK: - CreateTabs
    private func createTabs() {

        let item1 = LaundrySymbolsViewController()
        let icon1 = UITabBarItem(title: "", image: Images.questionMark, tag: 1)
        item1.tabBarItem = icon1

        let item2 = ClothesListViewController()
        let icon2 = UITabBarItem(title: "", image: nil, tag: 2)
        item2.tabBarItem = icon2

        let controllers = [item1, item2]
        self.viewControllers = controllers
    }

    // MARK: - UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
