import UIKit

class CreatedWashingViewController: ResultViewController {

    // MARK: - Properties
    private var color: ColorType
    private var temperature: Int
    private var washingMode: WashingMode
    private var washingName: String
    private var coincidence: Bool
    private var saveButton: CloNextButton!

    init(clothes: [Clothes]?,
         color: ColorType,
         temperature: Int,
         washingMode: WashingMode,
         washingName: String,
         coincidence: Bool) {

        self.color       = color
        self.temperature = temperature
        self.washingMode = washingMode
        self.washingName = washingName
        self.coincidence = coincidence

        super.init(clothes: clothes)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNextButton()
        setupNavigationBar()
        view().collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
    }

    // MARK: - Functions
    override func setupNavigationBar() {
        navigationItem.title = washingName
    }

    private func setupNextButton() {
        saveButton = CloNextButton(title: NSLocalizedString("Save", comment: ""),
                                   addTo: view)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        NSLayoutConstraint.activate([saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)])
    }

    private func saveWashing() {
        let washing = Washing(name: washingName,
                              color: color,
                              temperature: temperature,
                              washingMode: washingMode,
                              coincidence: coincidence,
                              creationDate: Date())
        saveButton.isProcessing = true

        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }

            CoreDataManager.shared.saveWashing(washing: washing) { result in
                DispatchQueue.main.async {
                    self.saveButton.isProcessing = false
                    switch result {
                    case .success:
                        FeedbackManager.success()
                        self.navigationController?.popToRootViewController(animated: true)

                    case .failure:
                        FeedbackManager.error()
                    }
                }
            }
        }
    }

    // MARK: - Actions
    @objc
    private func saveButtonPressed() {
        saveWashing()
    }
}
