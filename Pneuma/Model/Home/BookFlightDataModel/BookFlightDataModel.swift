//
//  BookFlightDataModel.swift
//  Pneuma
//
//  Created by Jatin on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

enum BookFlightScreenType {
    case bookFlight
    case planMyTrip
}

struct FlightBookRequestModel: Codable {
    var user_id: String?
    var origin: String?
    var departure_date: String?
    var arrival_date: String?
    var adults: String?
    var children: String?
    var infants: String?
    var cabin_class: String?
    var payment_method_id: String?
    var total_payment: Float?
    var destination: String?
    var estimated_time: String?
    var flight_no: String?
    var airline: String?
    var airline_image: String?
    var coupon_code: String?
    var discount: String?
    var email: String?
    var phone: String?
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case origin = "origin"
        case departure_date = "departure_date"
        case arrival_date = "arrival_date"
        case adults = "adults"
        case children = "children"
        case infants = "infants"
        case cabin_class = "cabin_class"
        case payment_method_id = "payment_method_id"
        case total_payment = "total_payment"
        case destination = "destination"
        case estimated_time = "estimated_time"
        case flight_no = "flight_no"
        case airline = "airline"
        case airline_image = "airline_image"
        case coupon_code = "coupon_code"
        case discount = "discount"
        case email = "email"
        case phone = "phone"
    }
}


struct FlightBookResponseModel: Codable {
    var statusCode: Int?
    var message: String?
}


// MARK: - CreateIntent
struct CreateIntent: Codable {
    var intent: Intent?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case intent = "intent"
        case message = "message"
    }
}

// MARK: - Intent
struct Intent: Codable {
    var id: String?
    var object: String?
    var amount: Int?
    var amountCapturable: Int?
    var amountReceived: Int?
    var application: String?
    var applicationFeeAmount: Int?
    var automaticPaymentMethods: String?
    var canceledAt: String?
    var cancellationReason: String?
    var captureMethod: String?
    var charges: Charges?
    var clientSecret: String?
    var confirmationMethod: String?
    var created: Int?
    var currency: String?
    var customer: String?
    var intentDescription: String?
    var invoice: String?
    var lastPaymentError: String?
    var livemode: Bool?
    var metadata: MetaData?
    var nextAction: String?
    var onBehalfOf: String?
    var paymentMethod: String?
    var paymentMethodOptions: PaymentMethodOptions?
    var paymentMethodTypes: [String]?
    var processing: String?
    var receiptEmail: String?
    var review: String?
    var setupFutureUsage: String?
    var shipping: String?
    var source: String?
    var statementDescriptor: String?
    var statementDescriptorSuffix:String?
    var status: String?
    var transferData: String?
    var transferGroup: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case object = "object"
        case amount = "amount"
        case amountCapturable = "amount_capturable"
        case amountReceived = "amount_received"
        case application = "application"
        case applicationFeeAmount = "application_fee_amount"
        case automaticPaymentMethods = "automatic_payment_methods"
        case canceledAt = "canceled_at"
        case cancellationReason = "cancellation_reason"
        case captureMethod = "capture_method"
        case charges = "charges"
        case clientSecret = "client_secret"
        case confirmationMethod = "confirmation_method"
        case created = "created"
        case currency = "currency"
        case customer = "customer"
        case intentDescription = "description"
        case invoice = "invoice"
        case lastPaymentError = "last_payment_error"
        case livemode = "livemode"
        case metadata = "metadata"
        case nextAction = "next_action"
        case onBehalfOf = "on_behalf_of"
        case paymentMethod = "payment_method"
        case paymentMethodOptions = "payment_method_options"
        case paymentMethodTypes = "payment_method_types"
        case processing = "processing"
        case receiptEmail = "receipt_email"
        case review = "review"
        case setupFutureUsage = "setup_future_usage"
        case shipping = "shipping"
        case source = "source"
        case statementDescriptor = "statement_descriptor"
        case statementDescriptorSuffix = "statement_descriptor_suffix"
        case status = "status"
        case transferData = "transfer_data"
        case transferGroup = "transfer_group"
    }
}

// MARK: - Charges
struct Charges: Codable {
    var object: String?
    var data: ChargeData?
    var hasMore: Bool?
    var totalCount: Int?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case object = "object"
        case data = "data"
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url = "url"
    }
}

// MARK: - PaymentMethodOptions
struct PaymentMethodOptions: Codable {
    var card: Card?

    enum CodingKeys: String, CodingKey {
        case card = "card"
    }
}

// MARK: - Card
struct Card: Codable {
    var installments: String?
    var network: String?
    var requestThreeDSecure: String?

    enum CodingKeys: String, CodingKey {
        case installments = "installments"
        case network = "network"
        case requestThreeDSecure = "request_three_d_secure"
    }
}

struct ChargeData: Codable {

}

struct MetaData: Codable {

}

// MARK: - CreateEphemeralKeyModel
struct CreateEphemeralKeyModel: Codable {
    var stripeCustomer: StripeCustomer?
    var data: DataClass?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case stripeCustomer = "stripe_customer"
        case data = "data"
        case message = "message"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    var id: String?
    var object: String?
    var associatedObjects: [AssociatedObject]?
    var created: Int?
    var expires: Int?
    var livemode: Bool?
    var secret: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case object = "object"
        case associatedObjects = "associated_objects"
        case created = "created"
        case expires = "expires"
        case livemode = "livemode"
        case secret = "secret"
    }
}

// MARK: - AssociatedObject
struct AssociatedObject: Codable {
    var id: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
    }
}

// MARK: - StripeCustomer
struct StripeCustomer: Codable {
    var id: String?
    var object: String?
    var address: String?
    var balance: Int?
    var created: Int?
    var currency: String?
    var defaultSource: String?
    var delinquent: Bool?
    var stripeCustomerDescription: String?
    var discount: String?
    var email: String?
    var invoicePrefix: String?
    var invoiceSettings: InvoiceSettings?
    var livemode: Bool?
    var metadata: MetaData?
    var name: String?
    var nextInvoiceSequence: Int?
    var phone: String?
    var preferredLocales: PreferredLocales?
    var shipping: String?
    var taxExempt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case object = "object"
        case address = "address"
        case balance = "balance"
        case created = "created"
        case currency = "currency"
        case defaultSource = "default_source"
        case delinquent = "delinquent"
        case stripeCustomerDescription = "description"
        case discount = "discount"
        case email = "email"
        case invoicePrefix = "invoice_prefix"
        case invoiceSettings = "invoice_settings"
        case livemode = "livemode"
        case metadata = "metadata"
        case name = "name"
        case nextInvoiceSequence = "next_invoice_sequence"
        case phone = "phone"
        case preferredLocales = "preferred_locales"
        case shipping = "shipping"
        case taxExempt = "tax_exempt"
    }
}

// MARK: - InvoiceSettings
struct InvoiceSettings: Codable {
    var customFields: String?
    var defaultPaymentMethod: String?
    var footer: String?

    enum CodingKeys: String, CodingKey {
        case customFields = "custom_fields"
        case defaultPaymentMethod = "default_payment_method"
        case footer = "footer"
    }
}

struct PreferredLocales: Codable {

}

// MARK: - PaymentIntentModel
struct PaymentIntentModel: Codable {
    var id: String?
    var object: String?
    var amount: Int?
    var amountCapturable: Int?
    var amountReceived: Int?
    var application: String?
    var applicationFeeAmount: String?
    var automaticPaymentMethods: AutomaticPaymentMethods?
    var canceledAt: String?
    var cancellationReason: String?
    var captureMethod: String?
    var charges: Charges?
    var clientSecret: String?
    var confirmationMethod: String?
    var created: Int?
    var currency: String?
    var customer: String?
    var paymentIntentModelDescription: String?
    var invoice: String?
    var lastPaymentError: String?
    var livemode: Bool?
    var metadata: Metadata?
    var nextAction: String?
    var onBehalfOf: String?
    var paymentMethod: String?
    var paymentMethodOptions: PaymentMethodOptions?
    var paymentMethodTypes: [String]?
    var processing: String?
    var receiptEmail: String?
    var review: String?
    var setupFutureUsage: String?
    var shipping: String?
    var source: String?
    var statementDescriptor: String?
    var statementDescriptorSuffix: String?
    var status: String?
    var transferData: String?
    var transferGroup: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case object = "object"
        case amount = "amount"
        case amountCapturable = "amount_capturable"
        case amountReceived = "amount_received"
        case application = "application"
        case applicationFeeAmount = "application_fee_amount"
        case automaticPaymentMethods = "automatic_payment_methods"
        case canceledAt = "canceled_at"
        case cancellationReason = "cancellation_reason"
        case captureMethod = "capture_method"
        case charges = "charges"
        case clientSecret = "client_secret"
        case confirmationMethod = "confirmation_method"
        case created = "created"
        case currency = "currency"
        case customer = "customer"
        case paymentIntentModelDescription = "description"
        case invoice = "invoice"
        case lastPaymentError = "last_payment_error"
        case livemode = "livemode"
        case metadata = "metadata"
        case nextAction = "next_action"
        case onBehalfOf = "on_behalf_of"
        case paymentMethod = "payment_method"
        case paymentMethodOptions = "payment_method_options"
        case paymentMethodTypes = "payment_method_types"
        case processing = "processing"
        case receiptEmail = "receipt_email"
        case review = "review"
        case setupFutureUsage = "setup_future_usage"
        case shipping = "shipping"
        case source = "source"
        case statementDescriptor = "statement_descriptor"
        case statementDescriptorSuffix = "statement_descriptor_suffix"
        case status = "status"
        case transferData = "transfer_data"
        case transferGroup = "transfer_group"
    }
}

// MARK: - AutomaticPaymentMethods
struct AutomaticPaymentMethods: Codable {
    var enabled: Bool?
}

// MARK: - EphemeralModel
struct EphemeralModel: Codable {
    var id: String?
    var object: String?
    var associatedObjects: [AssociatedObject]?
    var created: Int?
    var expires: Int?
    var livemode: Bool?
    var secret: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case object = "object"
        case associatedObjects = "associated_objects"
        case created = "created"
        case expires = "expires"
        case livemode = "livemode"
        case secret = "secret"
    }
}

// MARK: - CreateOrderResponse
struct CreateOrderResponse: Codable {
    var status: Bool?
    var data: CreateOrderData?
    //var message: String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        //case message = "message"
    }
}

// MARK: - DataClass
struct CreateOrderData: Codable {
    var type: String?
    var id: String?
    var associatedRecords: [AssociatedRecord]?
    var flightOffers: [FlightOffer]?
    var travelers: [Traveler]?
    var ticketingAgreement: TicketingAgreement?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case associatedRecords = "associatedRecords"
        case flightOffers = "flightOffers"
        case travelers = "travelers"
        case ticketingAgreement = "ticketingAgreement"
    }
}

// MARK: - AssociatedRecord
struct AssociatedRecord: Codable {
    var reference: String?
    var creationDate: String?
    var originSystemCode: String?
    var flightOfferId: String?

    enum CodingKeys: String, CodingKey {
        case reference = "reference"
        case creationDate = "creationDate"
        case originSystemCode = "originSystemCode"
        case flightOfferId = "flightOfferId"
    }
}

// MARK: - FlightOffer
struct FlightOffer: Codable {
    var type: String?
    var id: String?
    var source: String?
    var nonHomogeneous: Bool?
    var lastTicketingDate: String?
    var itineraries: [Itinerary2]?
    var price: FlightOfferPrice?
    var pricingOptions: PricingOptions2?
    var validatingAirlineCodes: [String]?
    var travelerPricings: [TravelerPricing]?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case source = "source"
        case nonHomogeneous = "nonHomogeneous"
        case lastTicketingDate = "lastTicketingDate"
        case itineraries = "itineraries"
        case price = "price"
        case pricingOptions = "pricingOptions"
        case validatingAirlineCodes = "validatingAirlineCodes"
        case travelerPricings = "travelerPricings"
    }
}

// MARK: - Itinerary
struct Itinerary2: Codable {
    var segments: [Segment]?

    enum CodingKeys: String, CodingKey {
        case segments = "segments"
    }
}

// MARK: - Co2Emission
struct Co2Emission: Codable {
    var weight: Int?
    var weightUnit: String?
    var cabin: String?

    enum CodingKeys: String, CodingKey {
        case weight = "weight"
        case weightUnit = "weightUnit"
        case cabin = "cabin"
    }
}

// MARK: - FlightOfferPrice
struct FlightOfferPrice: Codable {
    var currency: String?
    var total: String?
    var base: String?
    var fees: [Fee]?
    var grandTotal: String?
    var billingCurrency: String?

    enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case total = "total"
        case base = "base"
        case fees = "fees"
        case grandTotal = "grandTotal"
        case billingCurrency = "billingCurrency"
    }
}


// MARK: - PricingOptions
struct PricingOptions2: Codable {
    var fareType: [String]?
    var includedCheckedBagsOnly: Bool?

    enum CodingKeys: String, CodingKey {
        case fareType = "fareType"
        case includedCheckedBagsOnly = "includedCheckedBagsOnly"
    }
}

// MARK: - Tax
struct Tax: Codable {
    var amount: String?
    var code: String?

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case code = "code"
    }
}

// MARK: - TicketingAgreement
struct TicketingAgreement: Codable {
    var option: String?

    enum CodingKeys: String, CodingKey {
        case option = "option"
    }
}

// MARK: - Traveler
struct Traveler: Codable {
    var id: String?
    var dateOfBirth: String?
    var gender: String?
    var name: Name?
    var contact: Contact?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case dateOfBirth = "dateOfBirth"
        case gender = "gender"
        case name = "name"
        case contact = "contact"
    }
}

// MARK: - Contact
struct Contact: Codable {
    var purpose: String?
    var phones: [Phone]?
    var emailAddress: String?

    enum CodingKeys: String, CodingKey {
        case purpose = "purpose"
        case phones = "phones"
        case emailAddress = "emailAddress"
    }
}

// MARK: - Phone
struct Phone: Codable {
    var deviceType: String?
    var countryCallingCode: String?
    var number: String?

    enum CodingKeys: String, CodingKey {
        case deviceType = "deviceType"
        case countryCallingCode = "countryCallingCode"
        case number = "number"
    }
}

// MARK: - Name
struct Name: Codable {
    var firstName: String?
    var lastName: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case lastName = "lastName"
    }
}

struct PriceFareResponseModel: Codable {
    var status: Bool?
    var data: PriceFareResponse?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

// MARK: - PriceFareResponse
struct PriceFareResponse: Codable {
    var bookingRequirements: BookingRequirements?
    var flightOffers: [FlightOffer]?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case bookingRequirements = "bookingRequirements"
        case flightOffers = "flightOffers"
        case type = "type"
    }
}

// MARK: - BookingRequirements
struct BookingRequirements: Codable {
    var emailAddressRequired: Bool?
    var mobilePhoneNumberRequired: Bool?
    var travelerRequirements: [TravelerRequirement]?

    enum CodingKeys: String, CodingKey {
        case emailAddressRequired = "emailAddressRequired"
        case mobilePhoneNumberRequired = "mobilePhoneNumberRequired"
        case travelerRequirements = "travelerRequirements"
    }
}

// MARK: - TravelerRequirement
struct TravelerRequirement: Codable {
    var dateOfBirthRequired: Bool?
    var genderRequired: Bool?
    var redressRequiredIfAny: Bool?
    var residenceRequired: Bool?
    var travelerId: String?

    enum CodingKeys: String, CodingKey {
        case dateOfBirthRequired = "dateOfBirthRequired"
        case genderRequired = "genderRequired"
        case redressRequiredIfAny = "redressRequiredIfAny"
        case residenceRequired = "residenceRequired"
        case travelerId = "travelerId"
    }
}

//// MARK: - FlightOffer
//struct FlightOffer: Codable {
//    var id: String?
//    var instantTicketingRequired: Bool?
//    var itineraries: [Itinerary]?
//    var lastTicketingDate: String?
//    var nonHomogeneous: Bool?
//    var paymentCardRequired: Bool?
//    var price: FlightOfferPrice?
//    var pricingOptions: PricingOptions?
//    var source: String?
//    var travelerPricings: [TravelerPricing]?
//    var type: String?
//    var validatingAirlineCodes: [String]?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case instantTicketingRequired = "instantTicketingRequired"
//        case itineraries = "itineraries"
//        case lastTicketingDate = "lastTicketingDate"
//        case nonHomogeneous = "nonHomogeneous"
//        case paymentCardRequired = "paymentCardRequired"
//        case price = "price"
//        case pricingOptions = "pricingOptions"
//        case source = "source"
//        case travelerPricings = "travelerPricings"
//        case type = "type"
//        case validatingAirlineCodes = "validatingAirlineCodes"
//    }
//}
//
//// MARK: - Itinerary
//struct Itinerary: Codable {
//    var segments: [Segment]?
//
//    enum CodingKeys: String, CodingKey {
//        case segments = "segments"
//    }
//}
//
//// MARK: - Segment
//struct Segment: Codable {
//    var aircraft: Aircraft?
//    var arrival: Arrival?
//    var carrierCode: String?
//    var co2Emissions: [Co2Emission]?
//    var departure: Arrival?
//    var duration: String?
//    var id: String?
//    var number: String?
//    var numberOfStops: Int?
//    var operating: Operating?
//
//    enum CodingKeys: String, CodingKey {
//        case aircraft = "aircraft"
//        case arrival = "arrival"
//        case carrierCode = "carrierCode"
//        case co2Emissions = "co2Emissions"
//        case departure = "departure"
//        case duration = "duration"
//        case id = "id"
//        case number = "number"
//        case numberOfStops = "numberOfStops"
//        case operating = "operating"
//    }
//}
//
//// MARK: - Aircraft
//struct Aircraft: Codable {
//    var code: String?
//
//    enum CodingKeys: String, CodingKey {
//        case code = "code"
//    }
//}
//
//// MARK: - Arrival
//struct Arrival: Codable {
//    var at: String?
//    var iataCode: String?
//    var terminal: String?
//
//    enum CodingKeys: String, CodingKey {
//        case at = "at"
//        case iataCode = "iataCode"
//        case terminal = "terminal"
//    }
//}
//
//// MARK: - Co2Emission
//struct Co2Emission: Codable {
//    var cabin: String?
//    var weight: Int?
//    var weightUnit: String?
//
//    enum CodingKeys: String, CodingKey {
//        case cabin = "cabin"
//        case weight = "weight"
//        case weightUnit = "weightUnit"
//    }
//}
//
//// MARK: - Operating
//struct Operating: Codable {
//    var carrierCode: String?
//
//    enum CodingKeys: String, CodingKey {
//        case carrierCode = "carrierCode"
//    }
//}
//
//// MARK: - FlightOfferPrice
//struct FlightOfferPrice: Codable {
//    var base: String?
//    var billingCurrency: String?
//    var currency: String?
//    var fees: [Fee]?
//    var grandTotal: String?
//    var total: String?
//
//    enum CodingKeys: String, CodingKey {
//        case base = "base"
//        case billingCurrency = "billingCurrency"
//        case currency = "currency"
//        case fees = "fees"
//        case grandTotal = "grandTotal"
//        case total = "total"
//    }
//}
//
//// MARK: - Fee
//struct Fee: Codable {
//    var amount: String?
//    var type: String?
//
//    enum CodingKeys: String, CodingKey {
//        case amount = "amount"
//        case type = "type"
//    }
//}
//
//// MARK: - PricingOptions
//struct PricingOptions: Codable {
//    var fareType: [String]?
//    var includedCheckedBagsOnly: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case fareType = "fareType"
//        case includedCheckedBagsOnly = "includedCheckedBagsOnly"
//    }
//}
//
//// MARK: - TravelerPricing
//struct TravelerPricing: Codable {
//    var fareDetailsBySegment: [FareDetailsBySegment]?
//    var fareOption: String?
//    var price: TravelerPricingPrice?
//    var travelerId: String?
//    var travelerType: String?
//
//    enum CodingKeys: String, CodingKey {
//        case fareDetailsBySegment = "fareDetailsBySegment"
//        case fareOption = "fareOption"
//        case price = "price"
//        case travelerId = "travelerId"
//        case travelerType = "travelerType"
//    }
//}
//
//// MARK: - FareDetailsBySegment
//struct FareDetailsBySegment: Codable {
//    var cabin: String?
//    var fareDetailsBySegmentClass: String?
//    var fareBasis: String?
//    var segmentId: String?
//
//    enum CodingKeys: String, CodingKey {
//        case cabin = "cabin"
//        case fareDetailsBySegmentClass = "class"
//        case fareBasis = "fareBasis"
//        case segmentId = "segmentId"
//    }
//}
//
//// MARK: - TravelerPricingPrice
//struct TravelerPricingPrice: Codable {
//    var base: String?
//    var currency: String?
//    var refundableTaxes: String?
//    var taxes: [Tax]?
//    var total: String?
//
//    enum CodingKeys: String, CodingKey {
//        case base = "base"
//        case currency = "currency"
//        case refundableTaxes = "refundableTaxes"
//        case taxes = "taxes"
//        case total = "total"
//    }
//}
//
//// MARK: - Tax
//struct Tax: Codable {
//    var amount: String?
//    var code: String?
//
//    enum CodingKeys: String, CodingKey {
//        case amount = "amount"
//        case code = "code"
//    }
//}
