//
//  PaymentMethodModel.swift
//  Pneuma
//
//  Created by Chitra on 15/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class PaymentMethodListDataSourceModel: NSObject {
    var listArray = [PaymentMethodModel]()
}

class PaymentMethodModel {
    var title: String
    var isExpired: Bool
    var isSelected: Bool
    
    init(title: String, isExpired: Bool = false, isSelected: Bool = false) {
        self.title = title
        self.isExpired = isExpired
        self.isSelected = isSelected
    }
}

// MARK: - ChargeResponse
struct ChargeResponse: Codable {
    var data: DataClass2?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

// MARK: - DataClass
struct DataClass2: Codable {
    var addresses: Addresses?
    var cancelurl: String?
    var code: String?
    var createdAt: String?
    var dataDescription: String?
    var exchangeRates: ExchangeRates?
    var expiresAt: String?
    var feesSettled: Bool?
    var hostedurl: String?
    var id: String?
    var localExchangeRates: ExchangeRates?
    var metadata: Metadata2?
    var name: String?
    var paymentThreshold: PaymentThreshold?
    var payments: [String]?
    var pricing: Pricing?
    var pricingType: String?
    var pwcbOnly: Bool?
    var redirecturl: String?
    var resource: String?
    var supportEmail: String?
    var timeline: [Timeline]?
    var utxo: Bool?

    enum CodingKeys: String, CodingKey {
        case addresses = "addresses"
        case cancelurl = "cancel_url"
        case code = "code"
        case createdAt = "created_at"
        case dataDescription = "description"
        case exchangeRates = "exchange_rates"
        case expiresAt = "expires_at"
        case feesSettled = "fees_settled"
        case hostedurl = "hosted_url"
        case id = "id"
        case localExchangeRates = "local_exchange_rates"
        case metadata = "metadata"
        case name = "name"
        case paymentThreshold = "payment_threshold"
        case payments = "payments"
        case pricing = "pricing"
        case pricingType = "pricing_type"
        case pwcbOnly = "pwcb_only"
        case redirecturl = "redirect_url"
        case resource = "resource"
        case supportEmail = "support_email"
        case timeline = "timeline"
        case utxo = "utxo"
    }
}

// MARK: - Addresses
struct Addresses: Codable {
    var ethereum: String?
    var usdc: String?
    var dai: String?
    var bitcoincash: String?
    var dogecoin: String?
    var litecoin: String?
    var bitcoin: String?

    enum CodingKeys: String, CodingKey {
        case ethereum = "ethereum"
        case usdc = "usdc"
        case dai = "dai"
        case bitcoincash = "bitcoincash"
        case dogecoin = "dogecoin"
        case litecoin = "litecoin"
        case bitcoin = "bitcoin"
    }
}

// MARK: - ExchangeRates
struct ExchangeRates: Codable {
    var ethUsd: String?
    var btcUsd: String?
    var ltcUsd: String?
    var dogeUsd: String?
    var bchUsd: String?
    var usdcUsd: String?
    var daiUsd: String?

    enum CodingKeys: String, CodingKey {
        case ethUsd = "ETH-USD"
        case btcUsd = "BTC-USD"
        case ltcUsd = "LTC-USD"
        case dogeUsd = "DOGE-USD"
        case bchUsd = "BCH-USD"
        case usdcUsd = "USDC-USD"
        case daiUsd = "DAI-USD"
    }
}

// MARK: - Metadata
struct Metadata2: Codable {
    var customerid: String?
    var customerName: String?

    enum CodingKeys: String, CodingKey {
        case customerid = "customer_id"
        case customerName = "customer_name"
    }
}

// MARK: - PaymentThreshold
struct PaymentThreshold: Codable {
    var overpaymentAbsoluteThreshold: OverpaymentAbsoluteThreshold?
    var overpaymentRelativeThreshold: String?
    var underpaymentAbsoluteThreshold: OverpaymentAbsoluteThreshold?
    var underpaymentRelativeThreshold: String?

    enum CodingKeys: String, CodingKey {
        case overpaymentAbsoluteThreshold = "overpayment_absolute_threshold"
        case overpaymentRelativeThreshold = "overpayment_relative_threshold"
        case underpaymentAbsoluteThreshold = "underpayment_absolute_threshold"
        case underpaymentRelativeThreshold = "underpayment_relative_threshold"
    }
}

// MARK: - OverpaymentAbsoluteThreshold
struct OverpaymentAbsoluteThreshold: Codable {
    var amount: String?
    var currency: String?

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case currency = "currency"
    }
}

// MARK: - Pricing
struct Pricing: Codable {
    var local: OverpaymentAbsoluteThreshold?
    var ethereum: OverpaymentAbsoluteThreshold?
    var usdc: OverpaymentAbsoluteThreshold?
    var dai: OverpaymentAbsoluteThreshold?
    var bitcoincash: OverpaymentAbsoluteThreshold?
    var dogecoin: OverpaymentAbsoluteThreshold?
    var litecoin: OverpaymentAbsoluteThreshold?
    var bitcoin: OverpaymentAbsoluteThreshold?

    enum CodingKeys: String, CodingKey {
        case local = "local"
        case ethereum = "ethereum"
        case usdc = "usdc"
        case dai = "dai"
        case bitcoincash = "bitcoincash"
        case dogecoin = "dogecoin"
        case litecoin = "litecoin"
        case bitcoin = "bitcoin"
    }
}

// MARK: - Timeline
struct Timeline: Codable {
    var status: String?
    var time: String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case time = "time"
    }
}

