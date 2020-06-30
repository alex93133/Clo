import UIKit

class NewLaundryView: UIView {

    // MARK: - Properties
    var washingFilterView = WashingFilterView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
        setupWashingFilterViewConstraints()
        backgroundColor = Colors.mainBG
        washingFilterView.headLabel.removeFromSuperview()
    }


    // MARK: - Constraints
    private func setupWashingFilterViewConstraints() {
        addSubview(washingFilterView)
        washingFilterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            washingFilterView.topAnchor.constraint(equalTo: topAnchor),
            washingFilterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            washingFilterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            washingFilterView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
