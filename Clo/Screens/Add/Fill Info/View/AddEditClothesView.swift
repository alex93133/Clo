import UIKit

class AddEditClothesView: UIView {

    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    var clothesImageView: UIImageView!
    var inputFieldsView: InputFieldsView!
    var colorTypeCollectionView: ColorTypeCollectionView!
    var nextButton: CloNextButton!
    var nextButtonHandler: (() -> Void)?
    var changePhotoButton: UIButton!
    var changePhotoButtonHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollViewConstraints()
        setupStackView()
        setupClothesImageView()
        setupChangePhotoButton()
        setupInputFieldsViewConstraints()
        setupColorTypeCollectionViewConstraints()
        setupNextButton()
        backgroundColor = Colors.mainBG
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

    private func setupChangePhotoButton() {
        changePhotoButton = UIButton()
        changePhotoButton.addTarget(self, action: #selector(changePhotoButtonPressed), for: .touchUpInside)
        setupChangePhotoButtonConstraints()
    }

    // MARK: - NextButton
    private func setupNextButton() {
        nextButton = CloNextButton(title: "Next", action: #selector(nextButtonPressed), addTo: self)
        NSLayoutConstraint.activate([nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)])
    }

    // MARK: - Actions
    @objc
    private func changePhotoButtonPressed() {
        changePhotoButtonHandler?()
    }

    @objc
    private func nextButtonPressed() {
        nextButtonHandler?()
    }

    // MARK: - Constraints
    private func setupScrollViewConstraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupStackViewConstraints() {
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100),
            stackView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    private func setupClothesImageViewConstraints() {
        stackView.addArrangedSubview(clothesImageView)
        clothesImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clothesImageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 9 / 16),
            clothesImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 12),
            clothesImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -12),
            clothesImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0)
        ])
    }

    private func setupChangePhotoButtonConstraints() {
        addSubview(changePhotoButton)
        changePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changePhotoButton.leadingAnchor.constraint(equalTo: clothesImageView.leadingAnchor),
            changePhotoButton.trailingAnchor.constraint(equalTo: clothesImageView.trailingAnchor),
            changePhotoButton.topAnchor.constraint(equalTo: clothesImageView.topAnchor),
            changePhotoButton.bottomAnchor.constraint(equalTo: clothesImageView.bottomAnchor)
        ])
    }

    private func setupInputFieldsViewConstraints() {
        inputFieldsView = InputFieldsView()
        stackView.addArrangedSubview(inputFieldsView)
        inputFieldsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputFieldsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            inputFieldsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            inputFieldsView.heightAnchor.constraint(equalToConstant: 244),
            inputFieldsView.topAnchor.constraint(equalTo: clothesImageView.bottomAnchor, constant: 16)
        ])
    }

    private func setupColorTypeCollectionViewConstraints() {
        colorTypeCollectionView = ColorTypeCollectionView()
        stackView.addArrangedSubview(colorTypeCollectionView)
        colorTypeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorTypeCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            colorTypeCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            colorTypeCollectionView.heightAnchor.constraint(equalToConstant: 94),
            colorTypeCollectionView.topAnchor.constraint(equalTo: inputFieldsView.bottomAnchor)
        ])
    }
}
