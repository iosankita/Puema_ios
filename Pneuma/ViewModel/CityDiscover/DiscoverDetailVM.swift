//
//  DiscoverDetailVM.swift
//  Pneuma
//
//  Created by Chitra on 12/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class DiscoverDetailVM: NSObject {
    
    // MARK: - VARIABLES
    let dataSource = DiscoverDetailDataSource()
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getDetail()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getDetail() {
        let location = LocationModel(lat: 32.524646, long: 76.5248997, address: "Via Taranto, 70, 74015 Martina Franca, Italy")
        
        let review1 = ReviewModel(name: "Robert Fox", image: "", reviewTime: "month ago", reviewValue: 2.0, reviewText: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.")
        
        let review2 = ReviewModel(name: "Robert Fox", image: "", reviewTime: "2 months ago", reviewValue: 4.2, reviewText: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.")
        
        let ratings = RatingsModel(avgRating: 3.5, numberOfReviews: 2300, reviews: [review1, review2])
        self.dataSource.detailModel = DiscoverDetailModel(title: "Name", images: ["dummyImage", "dummyImage"], timings: "08:00-20:00", website: "www.test.com", location: location, ratings: ratings)
            
    }
}
