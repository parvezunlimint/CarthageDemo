import Foundation

/**
 Binding method data model
 */
public struct BindingMethodData: Codable {
    public struct MerchantOrder: Codable {
        /**
         Order ID used by the merchant's shopping cart
         */
        public let id: String
        /**
         Description of product/service being sold
         */
        public let description: String

        public init(description: String, id: String) {
            self.description = description
            self.id = id
        }
    }
    /**
     The currency for the lowest payment from card for binding
     */
    public let currency: Currency
    /**
     Customer data
     */
    public let customer: BindingCustomer
    /**
     Merchant order data
     */
    public let merchantOrder: MerchantOrder?
    /**
     Card account data
     */
    public let cardAccount: CheckCardAccount?

    // MARK: Init & Override

    /**
     Initializer
     */
    public init(currency: Currency,
                customer: BindingCustomer,
                merchantOrder: MerchantOrder? = nil,
                cardAccount: CheckCardAccount? = nil) {
        self.currency = currency
        self.customer = customer
        self.merchantOrder = merchantOrder
        self.cardAccount = cardAccount
    }
}
