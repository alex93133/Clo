import UIKit

class LaundryListView: UIView {

    // MARK: - Properties
    private var addButton: CloNewItemButton!
    var addButtonHandler: (() -> Void)!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAddButton()
        backgroundColor = Colors.mainBG
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - AddButton
    private func setupAddButton() {
        addButton = CloNewItemButton(title: NSLocalizedString("Collect", comment: ""),
                                     action: #selector(addButtonPressed),
                                     addTo: self)
    }

    @objc
    private func addButtonPressed() {
        addButtonHandler()
    }
}
