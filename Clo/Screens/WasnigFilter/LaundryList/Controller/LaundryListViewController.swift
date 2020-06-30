import UIKit

class LaundryListViewController: UIViewController {

    // MARK: - Properties
    private let customView = LaundryListView(frame: UIScreen.main.bounds)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Functions
    private func view() -> LaundryListView {
        return view as! LaundryListView
    }

    private func setupView() {
        view = customView
        navigationItem.title = NSLocalizedString("Laundry", comment: "")
        view().addButtonHandler = { [weak self] in
            guard let self = self else { return }
            self.presentNewLaundry()
        }
    }

    private func presentNewLaundry() {
    }
}
