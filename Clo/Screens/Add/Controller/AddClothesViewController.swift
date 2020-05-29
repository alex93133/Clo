import UIKit

class AddClothesViewController: UIViewController {

    // MARK: - Properties
    let customView = AddClothesView(frame: UIScreen.main.bounds)
    let clothingColors = ClothingColor.getAllClothingColors()
    let clothesPhoto: UIImage
    private var selectedColorIndexPath: IndexPath?

    init(image: UIImage? = nil) {
        self.clothesPhoto = image ?? UIImage()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Functions
    private func view() -> AddClothesView {
        return view as! AddClothesView
    }

    private func setupView() {
        view                                                     =  customView
        view().colorTypeCollectionView.collectionView.delegate   = self
        view().colorTypeCollectionView.collectionView.dataSource = self
        view().clothesImageView.image                            = clothesPhoto
        navigationItem.title                                     = "Add new item"
    }

}

// MARK: - Delegates
extension AddClothesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        clothingColors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesColorCellIdentifier, for: indexPath) as? ColorTypeCollectionViewCell {
            cell.colorTypeImageView.image = clothingColors[indexPath.item].image

            if selectedColorIndexPath != nil && indexPath.item != selectedColorIndexPath?.item {
                cell.colorTypeImageView.alpha = 0.5
            } else {
                cell.colorTypeImageView.alpha = 1
            }
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColorIndexPath = indexPath
        view().colorTypeCollectionView.collectionView.reloadData()
    }
}
