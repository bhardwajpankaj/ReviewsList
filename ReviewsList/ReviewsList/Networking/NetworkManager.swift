//
//  NetworkManager.swift
//  ReviewsList
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    
    enum URLError : Error {
        case URLISNIL
        case URLBadScheme
    }
    
    struct NetworkError : Error {
        var errorCode : String
        var errorType : String
    }
    
    static var shared = NetworkManager()
    private override init() {
        super.init()
    }
    
    private lazy var queue : OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
    
    private lazy var session : URLSession = {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: self.queue)
        return  session
    }()
    
    func getData(url : URL , completionHandler:@escaping(Data? , Error?)->Void) -> URLSessionTask {
        
        let sessionTask = self.session.dataTask(with: url) { (data, response, error) in
            completionHandler(data,error)
        }
        sessionTask.resume()
        return sessionTask
    }
}
