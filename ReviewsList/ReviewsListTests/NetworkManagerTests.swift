//
//  NetworkManagerTests.swift
//  ReviewsListTests
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import XCTest

@testable import ReviewsList

class NetworkManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAsyncCalback() {
        let pageSize = 10
        let pageNo = 0
        var requestUseCase :ReviewsRequestUseCase?
        
        let requestDTO = ReviewsRequestDTO(pageSize: pageSize, page: pageNo)
        requestUseCase = ReviewsRequestUseCase()
        requestUseCase?.initialize(requestDTO: requestDTO, completionHandler: { (responseDTO,error) in
            if(error != nil)
            {
                XCTFail(error.debugDescription)
            }else
            {
                if ((error) != nil){
                    XCTFail(error?.localizedDescription ?? "")
                }else {
                    XCTAssertTrue(true)
                }
            }
        })
    }
}
