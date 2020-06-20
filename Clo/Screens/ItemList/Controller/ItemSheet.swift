import FittedSheets
import UIKit

class ItemSheet {
   
    // MARK: - Properties
    var itemViewController: ItemViewController!
    var sheet: SheetViewController!

    init(items: [String]) {
        itemViewController = ItemViewController(items: items)
        setup()
    }

    // MARK: - Functions
    private func setup() {
        let safeZoneHeight: CGFloat        = 70
        let height: CGFloat                = Constants.colorTypeCellHeight * CGFloat(itemViewController.items.count) + safeZoneHeight
        sheet                              = SheetViewController(controller: itemViewController, sizes: [.fixed(height)])
        sheet.extendBackgroundBehindHandle = true
        sheet.blurBottomSafeArea           = false
        sheet.topCornersRadius             = 15
        sheet.overlay                      = Colors.overlay
    }
}
