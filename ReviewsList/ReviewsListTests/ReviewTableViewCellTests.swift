//
//  ReviewTableViewCellTests.swift
//  ReviewsListTests
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import XCTest
@testable import ReviewsList

class ReviewTableViewCellTests: XCTestCase {
    
    var reviewTableViewCell: ReviewTableViewCell?

        override func setUp() {
            super.setUp()
            let bundle = Bundle(for: ReviewTableViewCell.self)
            guard let cell = bundle.loadNibNamed("ReviewTableViewCell", owner: nil)?.first as? ReviewTableViewCell else {
                return XCTFail()
            }
            reviewTableViewCell = cell
            reviewTableViewCell?.prepareForReuse()
            
        }
    
    func test_updateInterface() {
        
        reviewTableViewCell?.updateInterface(review: Review(reviewID: 1, rating: "5", title: "Awesome", message: "NA", author: "Pankaj-India", foreignLanguage: true, date: "27 Jul, 2019", languageCode: "Fr", travelerType: "", reviewerName: "Pankaj", reviewerCountry: "India", reviewerProfilePhoto: nil, isAnonymous: true, firstInitial: "Bhardwaj"))
        
        XCTAssertEqual(reviewTableViewCell?.author.text!, "Pankaj-India")
        
    }
    func test_getConvertedDate() {
        
        let sut = reviewTableViewCell?.getConvertedDate(dateText:"July 29, 2019")

        XCTAssertEqual(sut == "29 July 2019", true)
    }
        override func tearDown() {
            super.tearDown()
        }
    
}
