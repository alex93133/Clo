import UIKit

class AddClothesView: UIView {

    // MARK: - Properties
    var clothesImageView: UIImageView!
    var inputFieldsView: InputFieldsView!
    var colorTypeCollectionView: ColorTypeCollectionView!
    var nextButton: UIButton!
    
    var nextButtonHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupClothesImageView()
        setupInputFieldsViewConstraints()
        setupColorTypeCollectionViewConstraints()
        setupNextButton()
        backgroundColor = Colors.whiteBGColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - ClothesImageView
    private func setupClothesImageView() {
        clothesImageView                     = UIImageView()
        clothesImageView.contentMode         = .scaleAspectFill
        clothesImageView.layer.masksToBounds = true

        setupClothesImageViewConstraints()
    }

    // MARK: - NextButton
    private func setupNextButton() {
        nextButton = NextButton(title: "Next", action: #selector(nextButtonPressed), addTo: self)
    }
}

// MARK: - Actions
extension AddClothesView {

    @objc func nextButtonPressed() {
        nextButtonHandler?()
    }
}

// MARK: - Constraints
extension AddClothesView {

    private func setupClothesImageViewConstraints() {
        addSubview(clothesImageView)

        clothesImageView.translatesAutoresizingMaskIntoConstraints                                = false
        clothesImageView.heightAnchor.constraint(equalToConstant: 203).isActive                   = true
        clothesImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive   = true
        clothesImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        clothesImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive           = true
    }

    private func setupInputFieldsViewConstraints() {
        inputFieldsView = InputFieldsView()
        addSubview(inputFieldsView)

        inputFieldsView.translatesAutoresizingMaskIntoConstraints                                           = false
        inputFieldsView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive                           = true
        inputFieldsView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive                         = true
        inputFieldsView.heightAnchor.constraint(equalToConstant: 244).isActive                              = true
        inputFieldsView.topAnchor.constraint(equalTo: clothesImageView.bottomAnchor, constant: 16).isActive = true
    }

    private func setupColorTypeCollectionViewConstraints() {
        colorTypeCollectionView = ColorTypeCollectionView()
        addSubview(colorTypeCollectionView)

        colorTypeCollectionView.translatesAutoresizingMaskIntoConstraints                            = false
        colorTypeCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive            = true
        colorTypeCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive          = true
        colorTypeCollectionView.heightAnchor.constraint(equalToConstant: 94).isActive                = true
        colorTypeCollectionView.topAnchor.constraint(equalTo: inputFieldsView.bottomAnchor).isActive = true
    }

}
