//
//  BaseRequestUseCase.swift
//  ReviewsList
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import Foundation


protocol BaseRequestDTO {
    func createGetRequestUrl(url:String)-> URL?
}

protocol BaseResponseDTO {}

class BaseRequestUseCase <S : BaseRequestDTO ,T : BaseResponseDTO > {
    
    func initialize(requestDTO : S)  {
        fatalError("This is an Abstract Base class, Method should be override")
        
    }
    func getDataFromServerUsingGet(url : URL, requestDto:S, completionHandler:@escaping(T?, Error?) -> Void) -> URLSessionTask{
        
        return NetworkManager.shared.getData(url:url) { (data, error) in
            if let error = error  {
                DispatchQueue.main.async {
                    completionHandler(nil,error)
                }
            }else{
                guard let unwrappedData = data else {
                    DispatchQueue.main.async {
                        completionHandler(nil,error)
                    }
                    return
                }
                do {
                    let response = try self.decode(data: unwrappedData)
                    DispatchQueue.main.async {
                        completionHandler(response,nil)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completionHandler(nil,error)
                    }
                }
            }
        }
    }
    
    func decode(data : Data)throws -> (T?) {
        fatalError("This is an Abstract Base class, Method should be override")
    }
}
