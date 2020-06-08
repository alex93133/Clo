import UIKit

class AddEditClothesView: UIView {

    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    var clothesImageView: UIImageView!
    var inputFieldsView: InputFieldsView!
    var colorTypeCollectionView: ColorTypeCollectionView!
    var nextButton: NextButton!

    var nextButtonHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollViewConstraints()
        setupStackView()
        setupClothesImageView()
        setupInputFieldsViewConstraints()
        setupColorTypeCollectionViewConstraints()
        setupNextButton()
        backgroundColor = Colors.whiteBGColor
        scrollView.showsVerticalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - StackView
    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis                                      = .vertical
        stackView.spacing                                   = 0
        setupStackViewConstraints()
    }

    // MARK: - ClothesImageView
    private func setupClothesImageView() {
        clothesImageView                     = UIImageView()
        clothesImageView.contentMode         = .scaleAspectFill
        clothesImageView.layer.cornerRadius  = Constants.defaultCornerRadius
        clothesImageView.layer.masksToBounds = true

        setupClothesImageViewConstraints()
    }

    // MARK: - NextButton
    private func setupNextButton() {
        nextButton = NextButton(title: "Next", action: #selector(nextButtonPressed), addTo: self)
        nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }
}

// MARK: - Actions
extension AddEditClothesView {

    @objc func nextButtonPressed() {
        nextButtonHandler?()
    }
}

// MARK: - Constraints
extension AddEditClothesView {

    private func setupScrollViewConstraints() {
        addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints                   = false
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive   = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive           = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive     = true
    }

    private func setupStackViewConstraints() {
        scrollView.addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive               = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive                       = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive             = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive                              = true
    }

    private func setupClothesImageViewConstraints() {
        stackView.addArrangedSubview(clothesImageView)

        clothesImageView.translatesAutoresizingMaskIntoConstraints                                            = false
        clothesImageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 9 / 16).isActive = true
        clothesImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 12).isActive    = true
        clothesImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -12).isActive  = true
        clothesImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive            = true
    }

    private func setupInputFieldsViewConstraints() {
        inputFieldsView = InputFieldsView()
        stackView.addArrangedSubview(inputFieldsView)

        inputFieldsView.translatesAutoresizingMaskIntoConstraints                                           = false
        inputFieldsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive                = true
        inputFieldsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive              = true
        inputFieldsView.heightAnchor.constraint(equalToConstant: 244).isActive                              = true
        inputFieldsView.topAnchor.constraint(equalTo: clothesImageView.bottomAnchor, constant: 16).isActive = true
    }

    private func setupColorTypeCollectionViewConstraints() {
        colorTypeCollectionView = ColorTypeCollectionView()
        stackView.addArrangedSubview(colorTypeCollectionView)

        colorTypeCollectionView.translatesAutoresizingMaskIntoConstraints                              = false
        colorTypeCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive   = true
        colorTypeCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        colorTypeCollectionView.heightAnchor.constraint(equalToConstant: 94).isActive                  = true
        colorTypeCollectionView.topAnchor.constraint(equalTo: inputFieldsView.bottomAnchor).isActive   = true
    }
}
