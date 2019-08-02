//
//  ReviewListControllerTests.swift
//  ReviewsListTests
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import XCTest
@testable import ReviewsList

class ReviewListControllerTests: XCTestCase {
    
    
    
    var reviewsViewController: ReviewListController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        reviewsViewController = navigationController.topViewController as? ReviewListController
        
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(reviewsViewController.view)
        
    }
    
    override func tearDown() {
        reviewsViewController = nil
        super.tearDown()
    }
    
    func testSUT_CanInstantiateViewController() {
        
        XCTAssertNotNil(reviewsViewController)
    }
    
    func testSUT_TableViewIsNotNilAfterViewDidLoad() {
        
        XCTAssertNotNil(reviewsViewController.tableView)
    }
    
    func testSUT_HasItemsForTableView() {
        
        XCTAssertNotNil(reviewsViewController.viewModel)
    }
    
    func testSUT_ShouldSetTableViewDataSource() {
        
        XCTAssertNotNil(reviewsViewController.tableView?.dataSource)
    }
    
    func testSUT_ConformsToTableViewDataSource() {
        
        XCTAssert(reviewsViewController.responds(to: #selector(reviewsViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssert(reviewsViewController.responds(to: #selector(reviewsViewController.tableView(_:cellForRowAt:))))
    }
    func testSUT_ConformsToTableViewDelegate() {
        
        XCTAssert(reviewsViewController.responds(to: #selector(reviewsViewController.tableView(_:willDisplay:forRowAt:))))
    }
    
    func testSUT_ShouldSetTableViewDelegate() {
        
        XCTAssertNotNil(reviewsViewController.tableView?.delegate)
    }
    
    
}
