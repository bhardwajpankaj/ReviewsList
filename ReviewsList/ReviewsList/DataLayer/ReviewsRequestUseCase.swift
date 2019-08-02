//
//  ReviewsRequestUseCase.swift
//  ReviewsList
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import Foundation

struct ReviewsRequestDTO : BaseRequestDTO {
    var pageSize : Int?
    var page : Int?
    func createGetRequestUrl(url:String)-> URL?{
        //TODO : create
        return URL(string: url + "\(page ?? 0)")
    }
    
}

struct ReviewsResponseDTO : BaseResponseDTO ,Decodable{
    let status: Bool?
    let totalReviewsComments: Int?
    var reviews: [Review]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalReviewsComments = "total_reviews_comments"
        case reviews = "data"
    }
}

class ReviewsRequestUseCase: BaseRequestUseCase<ReviewsRequestDTO,ReviewsResponseDTO > {
    
    var sessionTask : URLSessionTask?
    func initialize(requestDTO : ReviewsRequestDTO,completionHandler:@escaping(ReviewsResponseDTO?,Error?)->Void) {
        let baseUrl = Constants.allReviewsUrl
        //Constants.gitAllUsersUrl
        let url = requestDTO.createGetRequestUrl(url: baseUrl)
        sessionTask?.cancel()
        sessionTask = super.getDataFromServerUsingGet(url: url!, requestDto: requestDTO, completionHandler: completionHandler)
    }
    
    override func decode(data: Data) throws -> (ReviewsResponseDTO?) {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(ReviewsResponseDTO.self, from: data)
        }
    }
}

// Model
// MARK: - Review
struct Review: Codable {
    let reviewID: Int?
    let rating: String?
    let title: String?
    let message: String?
    let author: String?
    let foreignLanguage: Bool?
    let date: String?
    let languageCode: String?
    let travelerType: String?
    let reviewerName: String?
    let reviewerCountry: String?
    let reviewerProfilePhoto: String?
    let isAnonymous: Bool?
    let firstInitial: String?
    
    enum CodingKeys: String, CodingKey {
        case reviewID = "review_id"
        case rating = "rating"
        case title = "title"
        case message = "message"
        case author = "author"
        case foreignLanguage = "foreignLanguage"
        case date = "date"
        case languageCode = "languageCode"
        case travelerType = "traveler_type"
        case reviewerName = "reviewerName"
        case reviewerCountry = "reviewerCountry"
        case reviewerProfilePhoto = "reviewerProfilePhoto"
        case isAnonymous = "isAnonymous"
        case firstInitial = "firstInitial"
    }
}

