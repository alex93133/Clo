import Foundation

struct SymbolsSections {

    let title: String
    var items: [Symbol]
    var hidden = false

    static func getSections() -> [SymbolsSections] {
        guard let symbols = Symbols.allSymbols() else { return []}
        let sectionTitles = Categories.allCases.map { $0.rawValue }

        var symbolDictionary: [String: [Symbol]] = [:]
        for element in symbols {
            if symbolDictionary[element.category.rawValue] == nil {
                symbolDictionary[element.category.rawValue] = [Symbol]()
            }
            symbolDictionary[element.category.rawValue]!.append(element)
        }

        var sections = [SymbolsSections]()
        sections = sectionTitles.map { SymbolsSections(title: $0, items: symbolDictionary[$0]!) }

        return sections
    }
}
