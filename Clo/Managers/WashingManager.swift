import UIKit

struct WashingManager {

    var clothes: [Clothes]?
    let temperature: Int
    let color: ColorType
    let washingMode: WashingMode
    let coincidence: Bool

    static func presentViewWithWarning(symbol: Symbol, target: UIViewController) {
        let alert = CloAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        NSLayoutConstraint.activate([alert.view.heightAnchor.constraint(equalToConstant: 270)])

        let cancelAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel)
        alert.addAction(cancelAction)

        target.present(alert, animated: true)

        alert.imageView.image   = symbol.image
        alert.headLabel.text    = NSLocalizedString("Please note", comment: "")
        alert.messageLabel.text = NSLocalizedString("You should only wash your clothes by hand, so as not to damage it", comment: "")
    }

    static func presentViewWithError(symbol: Symbol, target: UIViewController) {
        let alert = CloAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        NSLayoutConstraint.activate([alert.view.heightAnchor.constraint(equalToConstant: 270)])

        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(cancelAction)

        target.present(alert, animated: true)

        alert.imageView.image   = symbol.image
        alert.headLabel.text    = NSLocalizedString("Attention!", comment: "")
        alert.messageLabel.text = NSLocalizedString("This clothes is not allowed to be washed, so you will damage it", comment: "")
    }

    enum DataFrom {
        case symbol(Symbol)
        case clothes(Clothes)
        case parameters (WashingMode, Int)
    }

    static func getWashingSymbol(data: DataFrom) -> Symbol {
        switch data {
        case .symbol(let symbol):
            return symbol

        case .clothes(let clothes):
            let washingSymbols = clothes.symbols.filter { $0.category == .washing }
            return washingSymbols.first!

        case .parameters(let washingMode, let temperature):
            let washingSymbols = Symbols.allSymbols()?.filter { $0.category == .washing }
            let filteredByTemperature = washingSymbols?.filter { WashingManager.getTemperature(data: .symbol($0)) == temperature }
            let filteredByWashingMode = filteredByTemperature?.filter { WashingManager.getWashingMode(data: .symbol($0)) == washingMode }
            return (filteredByWashingMode?.last)!
        }
    }

    static func getTemperature(data: DataFrom) -> Int? {
        let washingSymbol = WashingManager.getWashingSymbol(data: data)

        switch washingSymbol.id {
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

    static func getWashingMode(data: DataFrom) -> WashingMode? {
        let washingSymbol = WashingManager.getWashingSymbol(data: data)

        switch washingSymbol.id {
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
            self.clothes = clothes.filter { WashingManager.getTemperature(data: .clothes($0)) == temperature }
        } else {
            self.clothes = clothes.filter {
                guard let clothesTemperature = WashingManager.getTemperature(data: .clothes($0)) else { return false }
                return clothesTemperature >= temperature
            }
        }
    }

    private mutating func filterByWashingMode() {
        guard let clothes = clothes else { return }
        if coincidence {
            self.clothes = clothes.filter { WashingManager.getWashingMode(data: .clothes($0)) == washingMode }
        } else {
            switch washingMode {
            case .regular:
                self.clothes = clothes.filter { WashingManager.getWashingMode(data: .clothes($0)) == WashingMode.regular }

            case .gentle:
                self.clothes = clothes.filter { WashingManager.getWashingMode(data: .clothes($0)) != WashingMode.veryGentle }

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
