import UIKit

class LaundryDetailViewController: ResultViewController {

    // MARK: - Properties
    var laundry: Laundry
    var alertController: UIAlertController!

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

    private func presentActionSheet() {
        alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = Colors.mint

        let deleteAction = UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.deleteLaundry()
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)

        deleteAction.setValue(Images.deleteIcon, forKey: "image")

        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
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
        presentActionSheet()
    }
}
