import UIKit
import FittedSheets

struct PhotoSheet {
    
    var gallerySheet: SheetViewController!
    var galleryViewController: GalleryViewController!
    
    mutating func setupGallerySheet(height: CGFloat) -> SheetViewController {
        galleryViewController                     = GalleryViewController()
        gallerySheet                              = SheetViewController(controller: galleryViewController, sizes: [.fixed(height)])
        gallerySheet.extendBackgroundBehindHandle = true
        gallerySheet.adjustForBottomSafeArea      = true
        gallerySheet.blurBottomSafeArea           = true
        gallerySheet.topCornersRadius             = 15
        gallerySheet.overlayColor                 = Colors.overlayColor
        
        return gallerySheet
    }
    
    func handleDismiss() {
        gallerySheet.didDismiss = {  _ in
            self.galleryViewController.photoLibraryManager.runRequesting = false
        }
    }
}
