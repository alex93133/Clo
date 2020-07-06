import UIKit

class CloShadowView: UIView {

    // MARK: - Properties
    let containerView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    func layoutView() {
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor     = Colors.shadow.cgColor
        layer.shadowOffset    = CGSize(width: 0, height: 3)
        layer.shadowOpacity   = 1
        layer.shadowRadius    = Constants.shadowRadius

        containerView.backgroundColor    = Colors.additionalBG
        containerView.layer.cornerRadius = Constants.defaultCornerRadius
        containerView.clipsToBounds      = true

        setupContainerViewConstraints()
    }

    func addTo(view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Constraints
    private func setupContainerViewConstraints() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
