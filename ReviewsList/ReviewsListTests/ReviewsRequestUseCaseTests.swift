//
//  ReviewsRequestUseCaseTests.swift
//  ReviewsListTests
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import XCTest
@testable import ReviewsList
    
    class ReviewsRequestUseCaseTests: XCTestCase {
        
        override func setUp() {
            super.setUp()
            // Put setup code here. This method is called before the invocation of each test method in the class.
        }
        
        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
            super.tearDown()
        }
        
        func test_UserResponseDTO() {
            
            let sut = ReviewsResponseDTO(status: true, totalReviewsComments: 100, reviews: nil)
            
            XCTAssertEqual(sut.status, true)
        }
        func test_UserRequestDTO() {
            
            let sut = ReviewsRequestDTO(pageSize: 10, page: 0)
            XCTAssertEqual(sut.createGetRequestUrl(url: Constants.allReviewsUrl)?.absoluteString, "https://www.getyourguide.com/berlin-l17/tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776/reviews.json?count=5&page=0")
        }
        
        
}
