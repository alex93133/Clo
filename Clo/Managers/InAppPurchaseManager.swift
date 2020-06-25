import Foundation
import StoreKit

class InAppPurchaseManager: NSObject {

    static let shared = InAppPurchaseManager()
    override private init() {}

    var products: [SKProduct] = []

    func setupPurchases(callback: @escaping(Bool) -> Void) {
        if SKPaymentQueue.canMakePayments() {
            SKPaymentQueue.default().add(self)
            callback(true)
            return
        }
        callback(false)
    }

    func getProducts() {
        let identifiers: Set = Set(Identifiers.PurchasesID.allCases.map { $0.rawValue })

        let productRequest = SKProductsRequest(productIdentifiers: identifiers)
        productRequest.delegate = self
        productRequest.start()
    }
}

extension InAppPurchaseManager: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        print(response.invalidProductIdentifiers)
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    }
}
