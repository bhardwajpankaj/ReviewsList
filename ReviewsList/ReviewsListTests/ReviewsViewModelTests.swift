//
//  ReviewsViewModelTests.swift
//  ReviewsListTests
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import XCTest

@testable import ReviewsList

class MockReviewsRequestUseCase: ReviewsRequestUseCase {
    
    override func initialize(requestDTO : ReviewsRequestDTO,completionHandler:@escaping(ReviewsResponseDTO?,Error?)->Void) {
        let dto = ReviewsResponseDTO(status: nil, totalReviewsComments: nil, reviews: nil)
        completionHandler(dto,nil);
    }
    
    
}

class ReviewsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
    }
    
    func testAllUsersViewControllerViewModel() {
        let viewModel =  ReviewsViewModel()
        let useCase = MockReviewsRequestUseCase()
        viewModel.getUserInfoFromStarting(completionHandler: { (message) in
            if message != nil{
                //show Alert
                XCTFail(message!)
            }else {
                XCTAssertTrue(true)
            }
        } , useCase : useCase)
    }
    func testGetNextPaginationProducts() {
        let viewModel =  ReviewsViewModel()
        let useCase = MockReviewsRequestUseCase()
        
        viewModel.getNextUserInfo(completionHandler: { (message) in
            if message != nil{
                //show Alert
                XCTFail(message!)
            }else {
                XCTAssertTrue(true)
            }
        } , useCase : useCase)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
