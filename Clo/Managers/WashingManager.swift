import UIKit

struct WashingManager {

    var clothes: [Clothes]?
    let temperature: Int
    let color: ColorType
    let washingMode: WashingMode
    let coincidence: Bool

    static func presentViewWithWarning(symbol: Symbol, target: UIViewController) {
        let alert = CloAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(cancelAction)

        target.present(alert, animated: true)

        alert.imageView.image   = symbol.image
        alert.headLabel.text    = "Please note"
        alert.messageLabel.text = "You should only wash your clothes by hand, so as not to damage it"
    }

    static func presentViewWithError(symbol: Symbol, target: UIViewController) {
        let alert = CloAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(cancelAction)

        target.present(alert, animated: true)

        alert.imageView.image   = symbol.image
        alert.headLabel.text    = "Attention!"
        alert.messageLabel.text = "This clothes is not allowed to be washed, so you will damage it"
    }

    static func getTemperature(clothes: Clothes) -> Int? {
        let washingSymbol = clothes.symbols.filter { $0.category == .washing }
        guard let symbol = washingSymbol.first else { return nil }

        switch symbol.id {
        case 1...3, 6, 11, 16, 21, 26, 31:
            return 30

        case 7, 12, 17, 22, 27, 32:
            return 40

        case 8, 13, 18, 23, 28, 33:
            return 60

        case 9, 14, 19, 24, 29, 34:
            return 70

        case 10, 15, 20, 25, 30, 35:
            return 95

        default:
            return nil
        }
    }

    static func getWashingMode(clothes: Clothes) -> WashingMode? {
        let washingSymbol = clothes.symbols.filter { $0.category == .washing }
        guard let symbol = washingSymbol.first else { return nil }

        switch symbol.id {
        case 1, 6..<11, 21..<26:
            return .regular

        case 2, 11..<16, 26..<31:
            return .gentle

        case 3, 16..<21, 31..<36:
            return .veryGentle

        default:
            return nil
        }
    }

    private mutating func filterByColor() {
        if coincidence || temperature >= 40 {
            self.clothes = clothes?.filter { $0.color == color }
        }
    }

    private mutating func filterByTemperature() {
        guard let clothes = clothes else { return }
        if coincidence {
            self.clothes = clothes.filter { WashingManager.getTemperature(clothes: $0) == temperature }
        } else {
            self.clothes = clothes.filter {
                guard let clothesTemperature = WashingManager.getTemperature(clothes: $0) else { return false }
                return clothesTemperature >= temperature
            }
        }
    }

    private mutating func filterByWashingMode() {
        guard let clothes = clothes else { return }
        if coincidence {
            self.clothes = clothes.filter { WashingManager.getWashingMode(clothes: $0) == washingMode }
        } else {
            switch washingMode {
            case .regular:
                self.clothes = clothes.filter { WashingManager.getWashingMode(clothes: $0) == WashingMode.regular }

            case .gentle:
                self.clothes = clothes.filter { WashingManager.getWashingMode(clothes: $0) != WashingMode.veryGentle }

            case .veryGentle:
                return
            }
        }
    }

    mutating func filterClothes() -> [Clothes]? {
        filterByColor()
        filterByTemperature()
        filterByWashingMode()
        return clothes
    }
}
