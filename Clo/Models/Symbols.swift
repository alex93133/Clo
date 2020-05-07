import UIKit

struct Symbols: Codable {
    let symbols: [Symbol]

    static func allSymbols() -> [Symbol]? {
        if let url = Bundle.main.url(forResource: Constants.jsonFileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Symbols.self, from: data)
                return jsonData.symbols
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        return nil
    }
}

struct Symbol: Codable {
    let id: Int
    let category: Categories
    let description: String
    let imageName: String

    var image: UIImage? {
        return UIImage(named: imageName)
    }
}
