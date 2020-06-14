import UIKit
import FittedSheets

class PhotoSheet {
    
    // MARK: - Properties
    var gallerySheet: SheetViewController!
    var galleryViewController: GalleryViewController!
    
    // MARK: - Functions
    func setupGallerySheet(height: CGFloat) -> SheetViewController {
        galleryViewController                     = GalleryViewController()
        gallerySheet                              = SheetViewController(controller: galleryViewController, sizes: [.fixed(height)])
        gallerySheet.extendBackgroundBehindHandle = true
        gallerySheet.adjustForBottomSafeArea      = true
        gallerySheet.blurBottomSafeArea           = true
        gallerySheet.topCornersRadius             = 15
        gallerySheet.overlayColor                 = Colors.overlayColor
        return gallerySheet
    }
}
