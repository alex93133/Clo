import Foundation

struct Symbols: Codable {
    let symbols: [Symbol]

    static func allSymbols() -> [Symbol]? {
        if let url = Bundle.main.url(forResource: Identifiers.jsonFileName, withExtension: "json") {
            do {
                let data     = try Data(contentsOf: url)
                let decoder  = JSONDecoder()
                let jsonData = try decoder.decode(Symbols.self, from: data)
                return jsonData.symbols
            } catch {
                print("error.localizedDescription")
            }
        }
        return nil
    }
}
