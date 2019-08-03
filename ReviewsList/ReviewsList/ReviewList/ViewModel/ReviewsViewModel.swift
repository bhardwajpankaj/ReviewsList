//
//  ReviewsViewModel.swift
//  ReviewsList
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import Foundation


class ReviewsViewModel {
    
    private var currentPage : Int = 0
    private var pageSize : Int = 5
    private var requestUseCase :ReviewsRequestUseCase?
    var boolLoading : Bool = false
    var boolMoreDataAvailable : Bool = true
    var arrReviews : [Review]?
    var reviewModel : ReviewsResponseDTO?

    func getUserInfoFromStarting(completionHandler :@escaping (String?)->Void,useCase : ReviewsRequestUseCase = ReviewsRequestUseCase()) {
        currentPage = 0
        pageSize = 5
        boolMoreDataAvailable = true
        getUserInfo(pageNo: currentPage, pageSize: pageSize, completionHandler: completionHandler,useCase: useCase)
    }
    func getNextUserInfo(completionHandler :@escaping (String?)->Void,useCase : ReviewsRequestUseCase = ReviewsRequestUseCase()) {
        getUserInfo(pageNo: currentPage, pageSize: pageSize, completionHandler: completionHandler,useCase: useCase)
    }
    
    private func getUserInfo(pageNo : Int , pageSize : Int ,  completionHandler : @escaping(String?)->Void ,useCase : ReviewsRequestUseCase = ReviewsRequestUseCase() ) {
        boolLoading = true;
        let requestDTO = ReviewsRequestDTO(pageSize: pageSize, page: pageNo)
        requestUseCase = useCase
        requestUseCase?.initialize(requestDTO: requestDTO, completionHandler: { (responseDTO, error) in
            self.boolLoading = false
            if(error != nil)
            {
                completionHandler(error.debugDescription)
            }else
            {
                self.reviewModel = responseDTO
                if self.currentPage == 0 {
                    self.arrReviews = responseDTO?.reviews
                }else {
                    self.arrReviews = (self.arrReviews ?? []) + (responseDTO?.reviews ?? [])
                }
                
                if((responseDTO?.totalReviewsComments ?? 0) > self.arrReviews?.count ?? 0){
                    self.boolMoreDataAvailable = true
                }else{
                    self.boolMoreDataAvailable = false
                }
                
                self.currentPage = self.currentPage + 1
                completionHandler(nil)
            }
        })
    }
    
}
