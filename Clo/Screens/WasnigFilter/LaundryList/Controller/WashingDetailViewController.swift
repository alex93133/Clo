import UIKit

class WashingDetailViewController: ResultViewController {

    // MARK: - Properties
    var washing: Washing
    var alertController: UIAlertController!

    init(washing: Washing) {
        self.washing = washing
        let clothes = CoreDataManager.shared.fetchClothes { _ in }
        var washingManager = WashingManager(clothes: clothes,
                                            temperature: washing.temperature,
                                            color: washing.color,
                                            washingMode: washing.washingMode,
                                            coincidence: washing.coincidence)
        super.init(clothes: washingManager.filterClothes())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    override func setupNavigationBar() {
        navigationItem.title              = washing.name
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
            self.deleteWashing()
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)

        deleteAction.setValue(Images.deleteIcon, forKey: "image")

        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }

    private func deleteWashing() {
        CoreDataManager.shared.deleteWashing(washing: washing) { [weak self] result in
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
