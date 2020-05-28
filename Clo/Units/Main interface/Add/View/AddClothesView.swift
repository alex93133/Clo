import UIKit

class AddClothesView: UIView {

    // MARK: - Properties
    var clothesPhotoView: ClothesPhotoView!
    var inputFieldsView: UIView!
    var colorTypeCollectionView: ColorTypeCollectionView!
    var nextButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        clothesPhotoView = ClothesPhotoView(frame: UIScreen.main.bounds)
        addSubview(clothesPhotoView)
        colorTypeCollectionView = ColorTypeCollectionView(frame: UIScreen.main.bounds)
        addSubview(colorTypeCollectionView)
        inputFieldsView = InputFieldsView(frame: UIScreen.main.bounds)
        addSubview(inputFieldsView)

        setupNextButton()
        backgroundColor = Colors.whiteBGColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - NextButton
    private func setupNextButton() {
        nextButton = NextButton(title: "Next", action: #selector(nextButtonPressed), addTo: self)
    }
}

// MARK: - Actions
extension AddClothesView {

    @objc func nextButtonPressed() {
        print("hello")
    }
}
