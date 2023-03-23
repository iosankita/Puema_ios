//
//  UIStoryboard+Loader.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit

fileprivate enum Storyboards: String {
    case auth = "Authentication"
    case main = "Main"
    case home = "Home"
    case hotel = "Hotel"
    case ride = "Ride"
    case common = "Common"
    case payment = "Payment"
    case cityDiscover = "CityDiscover"
    case completeBooking = "CompleteBooking"
    case trip = "Trip"
    case driver = "Driver"
    case askannie = "AskAnnie"
}

fileprivate extension UIStoryboard {
    
    static func loadFromAuthStoryboard(_ identifier: String) -> UIViewController {
        let loginStoryboard = UIStoryboard(name: Storyboards.auth.rawValue, bundle: nil)
        let vc = loginStoryboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func loadFromMainStoryboard(_ identifier: String) -> UIViewController {
        let loginStoryboard = UIStoryboard(name: Storyboards.main.rawValue, bundle: nil)
        let vc = loginStoryboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func loadFromHomeStoryboard(_ identifier: String) -> UIViewController {
        let loginStoryboard = UIStoryboard(name: Storyboards.home.rawValue, bundle: nil)
        let vc = loginStoryboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func loadFromHotelStoryboard(_ identifier: String) -> UIViewController {
        let loginStoryboard = UIStoryboard(name: Storyboards.hotel.rawValue, bundle: nil)
        let vc = loginStoryboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func loadFromRideStoryboard(_ identifier: String) -> UIViewController {
        let loginStoryboard = UIStoryboard(name: Storyboards.ride.rawValue, bundle: nil)
        let vc = loginStoryboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func loadFromCommonStoryboard(_ identifier: String) -> UIViewController {
        let loginStoryboard = UIStoryboard(name: Storyboards.common.rawValue, bundle: nil)
        let vc = loginStoryboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func loadFromPaymentStoryboard(_ identifier: String) -> UIViewController {
        let loginStoryboard = UIStoryboard(name: Storyboards.payment.rawValue, bundle: nil)
        let vc = loginStoryboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func loadfromCityDiscoverStoryboard(_ identifier: String) -> UIViewController {
        let loginStoryboard = UIStoryboard(name: Storyboards.cityDiscover.rawValue, bundle: nil)
        let vc = loginStoryboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func loadFromCompleteBookingStoryboard(_ identifier: String) -> UIViewController {
        let loginStoryboard = UIStoryboard(name: Storyboards.completeBooking.rawValue, bundle: nil)
        let vc = loginStoryboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func loadFromTripStoryboard(_ identifier: String) -> UIViewController {
        let loginStoryboard = UIStoryboard(name: Storyboards.trip.rawValue, bundle: nil)
        let vc = loginStoryboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func loadFromDriverStoryboard(_ identifier: String) -> UIViewController {
        let loginStoryboard = UIStoryboard(name: Storyboards.driver.rawValue, bundle: nil)
        let vc = loginStoryboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    static func loadFromAskAnnieStoryboard(_ identifier: String) -> UIViewController {
        let askAnnieStoryboard = UIStoryboard(name: Storyboards.askannie.rawValue, bundle: nil)
        let vc = askAnnieStoryboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
}

//MARK:- LOAD FROM CITY DISCOVER STORYBOARD
extension UIStoryboard {
    static func loadCityDiscoverVC() -> CityDiscoverVC {
        return loadfromCityDiscoverStoryboard("CityDiscoverVC") as! CityDiscoverVC
    }
    
    static func laodDiscoverListVC() -> DiscoverListVC {
        return loadfromCityDiscoverStoryboard("DiscoverListVC") as! DiscoverListVC
    }
    
    static func laodDiscoverOptionDetailVC() -> DiscoverOptionDetailVC {
        return loadfromCityDiscoverStoryboard("DiscoverOptionDetailVC") as! DiscoverOptionDetailVC
    }
    
    static func loadDiscoverListVC() -> DiscoverListVC {
        return loadfromCityDiscoverStoryboard("DiscoverListVC") as! DiscoverListVC
    }
    
    static func loadDiscoverRouteVC() -> DiscoverRouteVC {
        return loadfromCityDiscoverStoryboard("DiscoverRouteVC") as! DiscoverRouteVC
    }
}

// MARK: - LOAD FROM Driver STORYBOARD
extension UIStoryboard {
    static func loadDriverDetailCompletedRideVC() -> DriverDetailCompletedRideVC {
        return loadFromDriverStoryboard("DriverDetailCompletedRideVC") as! DriverDetailCompletedRideVC
    }
    
    static func loadReportDriverReasonVC() -> ReportDriverReasonVC {
        return loadFromDriverStoryboard("ReportDriverReasonVC") as! ReportDriverReasonVC
    }
}

// MARK: - LOAD FROM Auth STORYBOARD
extension UIStoryboard {
    static func loadSignupVC() -> SignupVC {
        return loadFromAuthStoryboard("SignupVC") as! SignupVC
    }
    
    static func loadLoginVC() -> LoginVC {
        return loadFromAuthStoryboard("LoginVC") as! LoginVC
    }
    
    static func loadForgotPasswordVC() -> ForgotPasswordVC {
        return loadFromAuthStoryboard("ForgotPasswordVC") as! ForgotPasswordVC
    }
    
    static func loadResetPasswordVC() -> ResetPasswordVC {
           return loadFromAuthStoryboard("ResetPasswordVC") as! ResetPasswordVC
    }

    static func loadWelcomeContentVC() -> WelcomeContentVC {
        return loadFromAuthStoryboard("WelcomeContentVC") as! WelcomeContentVC
    }
    
    static func loadWelcomeVC() -> WelcomeVC {
        return loadFromAuthStoryboard("WelcomeVC") as! WelcomeVC
    }
    
    static func loadSplashVC() -> SplashVC {
        return loadFromAuthStoryboard("SplashVC") as! SplashVC
    }
    
    static func loadInitialQuestionsVC() -> InitialQuestionsVC {
        return loadFromAuthStoryboard("InitialQuestionsVC") as! InitialQuestionsVC
    }
    
    static func loadMyProfileVC() -> MyProfileVC {
        return loadFromAuthStoryboard("MyProfileVC") as! MyProfileVC
    }
    
    static func loadChangeProfileDataVC() -> ChangeProfileDataVC {
        return loadFromAuthStoryboard("ChangeProfileDataVC") as! ChangeProfileDataVC
    }
    
    static func loadMenuVC() -> MenuVC {
        return loadFromAuthStoryboard("MenuVC") as! MenuVC
    }
    
    static func loadTravelBuddyVC() -> TravelBuddyVC {
        return loadFromAuthStoryboard("TravelBuddyVC") as! TravelBuddyVC
    }
    
    static func loadSettingsVC() -> SettingsVC {
        return loadFromAuthStoryboard("SettingsVC") as! SettingsVC
    }
    
    static func loadAddTravelBuddyVC() -> AddTravelBuddyVC {
        return loadFromAuthStoryboard("AddTravelBuddyVC") as! AddTravelBuddyVC
    }
    
    static func loadWorldClockVC() -> WorldClockVC {
        return loadFromAuthStoryboard("WorldClockVC") as! WorldClockVC
    }
    
    static func loadSelectCurrencyVC() -> SelectCurrencyVC {
        return loadFromAuthStoryboard("SelectCurrencyVC") as! SelectCurrencyVC
    }
    
    static func loadMyTripsVC() -> MyTripsVC {
        return loadFromAuthStoryboard("MyTripsVC") as! MyTripsVC
    }
    
    static func loadTermsVC() -> TermsVC {
        return loadFromAuthStoryboard("TermsVC") as! TermsVC
    }
    
//    static func loadTermsVC() -> TermsVC {
//        return loadFromAuthStoryboard("TermsVC") as! TermsVC
//    }
}

//MARK:- LAOD FROM COMMON STORYBOARD
extension UIStoryboard {
    
    static func loadSearchCountryVC() -> SearchCountryVC {
        return loadFromCommonStoryboard("SearchCountryVC") as! SearchCountryVC
    }
    
    static func loadChooseDateVC() -> ChooseDateVC {
        return loadFromCommonStoryboard("ChooseDateVC") as! ChooseDateVC
    }
    
    static func loadTimeRangeVC() -> TimeRangeVC {
        return loadFromCommonStoryboard("TimeRangeVC") as! TimeRangeVC
    }

    static func loadChooseGenderVC() -> SelectGenderVC {
        return loadFromCommonStoryboard("SelectGenderVC") as! SelectGenderVC
    }
}

// MARK: - LOAD FROM RIDE STORYBOARD
extension UIStoryboard {
    
    static func loadCancelRideReasonVC() -> CancelRideReasonVC {
        return loadFromRideStoryboard("CancelRideReasonVC") as! CancelRideReasonVC
    }
    
    static func loadSearchDriverVC() -> SearchDriverVC {
        return loadFromRideStoryboard("SearchDriverVC") as! SearchDriverVC
    }
    
    static func loadGetRideVC() -> GetRideVC {
        return loadFromRideStoryboard("GetRideVC") as! GetRideVC
    }
    
    static func loadMyRidesVC() -> MyRidesVC {
        return loadFromRideStoryboard("MyRidesVC") as! MyRidesVC
    }
    
    static func loadRideInfoVC() -> RideInfoVC {
        return loadFromRideStoryboard("RideInfoVC") as! RideInfoVC
    }
}

// MARK: - LOAD FROM HOME STORYBOARD
extension UIStoryboard {
    
    static func loadPassengerInfoVC() -> PassengerInfoVC {
        return loadFromHomeStoryboard("PassengerInfoVC") as! PassengerInfoVC
    }
    
    static func loadPassengerPersonalInfoVC() -> PassengerPersonalInfoVC {
        return loadFromHomeStoryboard("PassengerPersonalInfoVC") as! PassengerPersonalInfoVC
    }
    
    static func loadPassengerContactInfoVC() -> PassengerContactInfoVC {
        return loadFromHomeStoryboard("PassengerContactInfoVC") as! PassengerContactInfoVC
    }
    
    static func loadPassengerTicketFilterVC() -> TicketFilterVC {
        return loadFromHomeStoryboard("TicketFilterVC") as! TicketFilterVC
    }
    
    static func loadHomeVC() -> HomeVC {
        return loadFromHomeStoryboard("HomeVC") as! HomeVC
    }
    
    static func loadBookFlightVC() -> BookFlightVC {
        return loadFromHomeStoryboard("BookFlightVC") as! BookFlightVC
    }
    
    static func loadChooseAddressVC() -> ChooseAddressVC {
        return loadFromHomeStoryboard("ChooseAddressVC") as! ChooseAddressVC
    }
    
    static func loadAdditionalOptionVC() -> AdditionalOptionVC {
        return loadFromHomeStoryboard("AdditionalOptionVC") as! AdditionalOptionVC
    }
    static func loadPopUp() -> CustomListPopupVC {
        return loadFromHomeStoryboard("CustomListPopupVC") as! CustomListPopupVC
    }
    static func loadSearchFlightsVC() -> SearchFlightsVC {
        return loadFromHomeStoryboard("SearchFlightsVC") as! SearchFlightsVC
    }
    
    static func loadOutboundDetailVC() -> OutboundDetailVC {
        return loadFromHomeStoryboard("OutboundDetailVC") as! OutboundDetailVC
    }
    
    static func loadPaymentInfoVC() -> PaymentInfoVC {
        return loadFromHomeStoryboard("PaymentInfoVC") as! PaymentInfoVC
    }
    
    static func loadCryptoPaymentVC() -> CryptoPaymentVC {
        return loadFromHomeStoryboard("CryptoPaymentVC") as! CryptoPaymentVC
    }
    
    static func loadFlightBookingCompletedVC() -> FlightBookingCompletedVC {
        return loadFromHomeStoryboard("FlightBookingCompletedVC") as! FlightBookingCompletedVC
    }
    
    static func loadFlightTicketsVC() -> FlightTicketsVC {
        return loadFromHomeStoryboard("FlightTicketsVC") as! FlightTicketsVC
    }
}

// MARK: - LOAD FROM HOTEL STORYBOARD
extension UIStoryboard {
    static func loadHotelSortByVC() -> HotelSortByVC {
        return loadFromHotelStoryboard("HotelSortByVC") as! HotelSortByVC
    }
    
    static func loadBookingCompleteVC() -> BookingCompleteVC {
        return loadFromHotelStoryboard("BookingCompleteVC") as! BookingCompleteVC
    }
    
    static func loadFindHotelVC() -> FindHotelVC {
        return loadFromHotelStoryboard("FindHotelVC") as! FindHotelVC
    }
    
    static func loadHotelAdditionalOptionVC() -> HotelAdditionalOptionVC {
        return loadFromHotelStoryboard("HotelAdditionalOptionVC") as! HotelAdditionalOptionVC
    }
    
    static func loadHotelSearchResultVC() -> HotelSearchResultVC {
        return loadFromHotelStoryboard("HotelSearchResultVC") as! HotelSearchResultVC
    }
    
    static func loadHotelInfoVC() -> HotelInfoVC {
        return loadFromHotelStoryboard("HotelInfoVC") as! HotelInfoVC
    }
    
    static func loadViewPhotosVC() -> ViewPhotosVC {
        return loadFromHotelStoryboard("ViewPhotosVC") as! ViewPhotosVC
    }
    
    static func loadMapVC() -> MapVC {
        return loadFromHotelStoryboard("MapVC") as! MapVC
    }
    
    static func loadSearchResultVC() -> SearchResultVC {
        return loadFromHotelStoryboard("SearchResultVC") as! SearchResultVC
    }
    
    static func loadHotelBookingsVC() -> HotelBookingsVC {
        return loadFromHotelStoryboard("HotelBookingsVC") as! HotelBookingsVC
    }
    
    static func loadEmergencyContactVC() -> EmergencyContactVC {
        return loadFromHotelStoryboard("EmergencyContactVC") as! EmergencyContactVC
    }
}

// MARK: - LOAD FROM PAYMENT STORYBOARD
extension UIStoryboard {
    static func loadPaymentMethodVC() -> PaymentMethodVC {
        return loadFromPaymentStoryboard("PaymentMethodVC") as! PaymentMethodVC
    }
    
    static func loadAddPaymentMethodVC() -> AddPaymentMethodVC {
        return loadFromPaymentStoryboard("AddPaymentMethodVC") as! AddPaymentMethodVC
    }
    
    static func loadPaymentMethodListVC() -> PaymentMethodListVC {
        return loadFromPaymentStoryboard("PaymentMethodListVC") as! PaymentMethodListVC
    }
}

// MARK: - LOAD FROM COMPLETE BOOKING STORYBOARD
extension UIStoryboard {
    static func loadPayVC() -> PayVC {
        return loadFromCompleteBookingStoryboard("PayVC") as! PayVC
    }
    
    static func loadMultipleBookingsCompletedVC() -> MultipleBookingsCompletedVC {
        return loadFromCompleteBookingStoryboard("MultipleBookingsCompletedVC") as! MultipleBookingsCompletedVC
    }
}

// MARK: - LOAD FROM TRIP BOOKING STORYBOARD
extension UIStoryboard {
    static func loadRideDetailVC() -> TripDetailVC {
        return loadFromTripStoryboard("TripDetailVC") as! TripDetailVC
    }
}

// MARK: - LOAD FROM ASK ANNIE STORYBOARD
extension UIStoryboard {
    static func loadAskAnnieVC() -> AskAnnieVC {
        return loadFromAskAnnieStoryboard("AskAnnieVC") as! AskAnnieVC
    }
}
