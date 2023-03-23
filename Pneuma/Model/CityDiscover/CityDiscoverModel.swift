//
//  CityDiscoverModel.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class CityDiscoverDataSourceModel: NSObject {
    var listArray = [CityDiscoverModel]()
}

enum CityDiscoverType: String {
    case restaurants = "Restaurants"
    case cinemaTheater = "Cinema Theater"
    case museums = "Museums"
    case shoppingCenters = "Shopping Centers"
    case sights = "Sights"
    case funPlace = "Fun Places"
    
    var image: String {
        switch self {
        case .restaurants:
            return "ic-\(self.rawValue)"
        case .cinemaTheater:
            return "ic-\(self.rawValue)"
        case .museums:
            return "ic-\(self.rawValue)"
        case .shoppingCenters:
            return "ic-\(self.rawValue)"
        case .sights:
            return "ic-\(self.rawValue)"
        case .funPlace:
            return "ic-\(self.rawValue)"
        }
    }
}

class CityDiscoverModel {
    var image: String
    var title: String
    var type: CityDiscoverType
    
    init(image: String, title: String, type: CityDiscoverType) {
        self.image = image
        self.title = title
        self.type = type
    }
}


//MARK:- LISTINGS

class DiscoverListDataSourceModel: NSObject {
    var listArray = [CityDiscoverListModel]()
}

class CityDiscoverListModel {
    var name: String
    var address: String
    var rating: Int
    var images: [String]
    var openingHours: String?
    
    init(name: String, address: String, rating: Int, images: [String], openingHours: String? = nil) {
        self.name = name
        self.address = address
        self.rating = rating
        self.images = images
        self.openingHours = openingHours
    }
}

//MARK:- DETAIL
class DiscoverDetailDataSourceModel: NSObject {
    var detailModel: DiscoverDetailModel!
}

class DiscoverDetailModel: NSObject {
    var title: String
    var images: [String]
    var timings: String
    var website: String
    var location: LocationModel
    var rating: RatingsModel
    
    init(title: String, images: [String], timings: String, website: String, location: LocationModel, ratings: RatingsModel) {
        self.title = title
        self.images = images
        self.timings = timings
        self.website = website
        self.location = location
        self.rating = ratings
    }
}

class LocationModel {
    var lat: Double
    var long: Double
    var address: String
    
    init(lat: Double, long: Double, address: String) {
        self.lat = lat
        self.long = long
        self.address = address
    }
}

class RatingsModel {
    var avgRating: Double
    var numberOfReviews: Int
    var reviews: [ReviewModel]
    
    init(avgRating: Double, numberOfReviews: Int, reviews: [ReviewModel]) {
        self.avgRating = avgRating
        self.numberOfReviews = numberOfReviews
        self.reviews = reviews
    }
}

class ReviewModel: Codable {
    var name: String?
    var image: String?
    var reviewTime: String?
    var reviewValue: Double?
    var reviewText: String?
    
    init(name: String, image: String, reviewTime: String, reviewValue: Double, reviewText: String) {
        self.name = name
        self.image = image
        self.reviewTime = reviewTime
        self.reviewValue = reviewValue
        self.reviewText = reviewText
    }
}
