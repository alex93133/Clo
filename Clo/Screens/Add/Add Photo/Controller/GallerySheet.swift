import FittedSheets
import UIKit

class GallerySheet {

    // MARK: - Properties
    var sheet: SheetViewController!
    var gallery: GalleryViewController!

    init(height: CGFloat) {
        setup(height: height)
    }

    // MARK: - Functions
    private func setup(height: CGFloat) {
        gallery                            = GalleryViewController()
        sheet                              = SheetViewController(controller: gallery, sizes: [.fixed(height)])
        sheet.extendBackgroundBehindHandle = true
        sheet.blurBottomSafeArea           = false
        sheet.topCornersRadius             = 15
        sheet.overlay                      = Colors.overlay
    }
}
