import UIKit

class LaundryDetailViewController: ResultViewController {

    // MARK: - Properties
    var laundry: Laundry

    init(laundry: Laundry) {
        self.laundry = laundry
        let clothes = CoreDataManager.shared.fetchClothes { _ in }
        var washingManager = WashingManager(clothes: clothes,
                                            temperature: laundry.temperature,
                                            color: laundry.color,
                                            washingMode: laundry.washingMode,
                                            coincidence: laundry.coincidence)
        super.init(clothes: washingManager.filterClothes())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    override func setupNavigationBar() {
        navigationItem.title              = laundry.name
        let deleteUIBarButtonItem         = UIBarButtonItem(image: Images.deleteIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(deleteButtonPressed))
        deleteUIBarButtonItem.tintColor   = UIColor.red
        navigationItem.rightBarButtonItem = deleteUIBarButtonItem
    }

    private func deleteLaundry() {
        CoreDataManager.shared.deleteLaundry(laundry: laundry) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                FeedbackManager.success()
                self.navigationController?.popViewController(animated: true)

            case let .failure(error):
                FeedbackManager.error()
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Actions
    @objc
    private func deleteButtonPressed() {
        deleteLaundry()
    }
}
