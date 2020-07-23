import UIKit

class NewLaundryViewController: WashingFilterViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }

    // MARK: - Functions
    private func setupView() {
        view                             = customView
        view().delegate                  = self
        view().nameTextField.delegate    = self
        view().headLabel.isHidden        = true
        view().nameTextField.isHidden    = false
        view().laundryNameLabel.isHidden = false
        view().topConstraint.constant    = -36
        view().nextButton.enableButton(isOn: false)
    }

    private func setupNavigationBar() {
        navigationItem.title = NSLocalizedString("Collect the wash", comment: "")
    }

    override func presentResult(clothes: [Clothes]?) {
        let createdLaundryViewController = CreatedLaundryViewController(clothes: clothes,
                                                                        color: color,
                                                                        temperature: temperature,
                                                                        washingMode: washingMode,
                                                                        laundryName: laundryName,
                                                                        coincidence: view().switcher.isOn)
        navigationController?.pushViewController(createdLaundryViewController, animated: true)
    }
}
