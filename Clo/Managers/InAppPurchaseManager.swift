import Foundation
import StoreKit

class InAppPurchaseManager: NSObject {

    // MARK: - Properties
    static let shared = InAppPurchaseManager()
    override private init() {}

    var products: [SKProduct] = []
    let paymentQueue = SKPaymentQueue.default()

    // MARK: - Functions
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

    func purchase(product: SKProduct) {
        let payment = SKPayment(product: product)
        paymentQueue.add(payment)
    }
}

// MARK: - Delegates
extension InAppPurchaseManager: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products.sorted { $0.price.doubleValue < $1.price.doubleValue }
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: Identifiers.Notifications.productsGot)))
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .failed:
                print("failed")
                paymentQueue.finishTransaction(transaction)

            case .purchased:
                print("purchased")
                paymentQueue.finishTransaction(transaction)

            default:
                break
            }
        }
    }
}
