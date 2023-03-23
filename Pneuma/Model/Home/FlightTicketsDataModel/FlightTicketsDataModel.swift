//
//  FlightTicketsDataModel.swift
//  Pneuma
//
//  Created by MacBook Pro on 26/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

struct GetFlightBookingsResponseModel: Codable {
    var statusCode: Int?
    var data: [FlightModel]?
    //var message: String?
    //var token: String?
}

struct GetFlightUpcomingAndPastBookingResponseModel: Codable {
    var status: Bool?
    var data: [FlightModel]?
}


class FlightModel : Codable {
    var id: Int?
    var user_id: Int?
    var origin: String?
    var departure_date: String?
    var arrival_date: String?
    var adults: Int?
    var children: Int?
    var infants: Int?
    var cabin_class: String?
    var payment_method_id: Int?
    var total_payment: String?
    var destination: String?
    var estimated_time: String?
    var flight_no: String?
    var airline: String?
    var created_at: String?
    var updated_at: String?
    var airline_image: String
    let paymentMethod: FlightPaymentMethod?
}

// MARK: - PaymentMethod
struct FlightPaymentMethod: Codable {
    let id: Int?
    let name, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

class FlightTicketTableDataSourceModel: NSObject {
    var listArray = [FlightBookings]()
}

struct CustomerModel : Codable{
    var id: String?
    var object: String?
    var address: String?
    var balance: Int?
    var created: Int?
    var currency: String?
    var defaultSource: String?
    var delinquent: Bool?
    var customerModelDescription: String?
    var discount: String?
    var email: String?
    var invoicePrefix: String?
    var invoiceSettings: InvoiceSettings?
    var livemode: Bool?
    var metadata: Metadata?
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
            case customerModelDescription = "description"
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

// MARK: - Metadata
struct Metadata : Codable {
}

// MARK: - GetFlightBookingsDetail
struct GetFlightBookingsDetail: Codable {
    var status: Bool?
    var data: [FlightBookings]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

// MARK: - FlightBookings
struct FlightBookings: Codable {
    var id: Int?
    var flightNo: String?
    var userid: Int?
    var origin: String?
    var destination: String?
    var departureDate: String?
    var arrivalDate: String?
    var airline: String?
    var adults: Int?
    var children: Int?
    var infants: Int?
    var cabinClass: String?
    var estimatedTime: String?
    var totalPayment: Double?
    var paymentMethodid: Int?
    var createdAt: String?
    var updatedAt: String?
    var airlineImage: String?
    var isReferral: Int?
    var discount: String?
    var email: String?
    var phone: String?
    var paymentMethod: PaymentMethod?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case flightNo = "flight_no"
        case userid = "user_id"
        case origin = "origin"
        case destination = "destination"
        case departureDate = "departure_date"
        case arrivalDate = "arrival_date"
        case airline = "airline"
        case adults = "adults"
        case children = "children"
        case infants = "infants"
        case cabinClass = "cabin_class"
        case estimatedTime = "estimated_time"
        case totalPayment = "total_payment"
        case paymentMethodid = "payment_method_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case airlineImage = "airline_image"
        case isReferral = "is_referral"
        case discount = "discount"
        case email = "email"
        case phone = "phone"
        case paymentMethod = "payment_method"
    }
}

// MARK: - PaymentMethod
struct PaymentMethod: Codable {
    var id: Int?
    var name: String?
    var createdAt: String?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
