import Foundation

struct SymbolsSections {

    let index: Int
    let title: String
    var category: Categories?
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
        sections = sectionTitles.map { SymbolsSections(index: sectionTitles.firstIndex(of: $0)! + 1,
                                                       title: $0,
                                                       category: Categories(rawValue: $0),
                                                       items: symbolDictionary[$0]!) }

        return sections
    }
}
