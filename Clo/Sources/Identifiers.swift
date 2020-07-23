import Foundation

enum Identifiers {
    static let addNewItemCellIdentifier     = "AddNewItem"
    static let cameraInputCellIdentifier    = "CameraInput"
    static let clothesCellIdentifier        = "Clothes"
    static let clothesColorCellIdentifier   = "ClothesColor"
    static let clothesSymbolsCellIdentifier = "ClothesSymbols"
    static let colorTypeCellIdentifier      = "ColorType"
    static let jsonFileName                 = "Symbols"
    static let laundryCellIdentifier        = "Laundry"
    static let menuItemCellIdentifier       = "MenuItem"
    static let photoCellIdentifier          = "PhotoFromGallery"
    static let symbolCellIdentifier         = "LaundrySymbol"
    static let symbolHeaderIdentifier       = "LaundryHeader"

    enum DetailCells {
        static let photoCellIdentifier        = "SelectedPhoto"
        static let symbolsCellIdentifier      = "SelectedSymbols"
        static let typeWithInfoCellIdentifier = "SelectedTypeAndInfo"
    }

    enum PurchasesID: String, CaseIterable {
        case americano  = "Clo.americano"
        case cappuccino = "Clo.cappuccino"
        case latte      = "Clo.latte"
    }

    enum Notifications {
        static let productsGot = "ProductsGot"
    }
}
