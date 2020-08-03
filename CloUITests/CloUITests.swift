import XCTest

class CloUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testClothesListSnapshot() throws {
        snapshot("Clothes list")
    }

    func testSymbolInfo() throws {
        app.tabBars.children(matching: .button).element(boundBy: 0).tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 5).children(matching: .other).element(boundBy: 1).children(matching: .other).element.tap()
        snapshot("Symbol info")
    }

    func testWashingList() throws {
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        snapshot("Washing list")
    }

    func testDetailInfo() throws {
        app.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.tap()
        snapshot("Detail info")
    }

    func testWashingFilter() throws {
        app.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element/*@START_MENU_TOKEN@*/.press(forDuration: 1.2);/*[[".tap()",".press(forDuration: 1.2);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        snapshot("Create washing")
    }
}
