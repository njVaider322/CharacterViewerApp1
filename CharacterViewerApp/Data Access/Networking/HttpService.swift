//
//  HttpService.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import Foundation

class HttpService: HttpInterface {
    
    fileprivate let queueContainer = QueueContainer.sharedInstance
    
    init() {
    }
    
    func httpGet(forUrl urlStr:String, httpData:@escaping (Data?,NSError?)-> Void) {
        
        let url     = URL(string: urlStr)!
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.HttpMethods.Get
        
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest  = 10 // Set time out to 10 seconds
        configuration.timeoutIntervalForResource = 10 // Set time out to 10 seconds
        
        let session  = URLSession(configuration: configuration)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            var statusCodeStr    = ""
            var errorDescription = ""
            var httpErrorMsg     = ""
            var statusCodeValue   = 0
            
            //Check for nil data or nil response or error not equal to nil
            guard data != nil, response != nil, error == nil else {
                
                if let httpResponse = response {
                    statusCodeValue = (httpResponse as! HTTPURLResponse).statusCode
                    statusCodeStr = HTTPURLResponse.localizedString(forStatusCode: statusCodeValue)
                }
                
                if let httpError = error {
                    errorDescription = httpError.localizedDescription
                    httpErrorMsg     = "An error occurred with description - \(errorDescription)"
                }
                
                if statusCodeStr.count > 0 {
                    httpErrorMsg += "\n HTTPURLResponse status code is \(statusCodeValue)"
                }
                
                let responseError = NSError(domain: Constants.ErrorDomains.ResponseError, code: 50, userInfo: [NSLocalizedDescriptionKey:httpErrorMsg])
                
                httpData(data,responseError)
                return
            }
            
            //Check for an http status code thats not 200
            guard (response as! HTTPURLResponse).statusCode == 200 else {
                
                statusCodeValue = (response as! HTTPURLResponse).statusCode
                statusCodeStr   = HTTPURLResponse.localizedString(forStatusCode: statusCodeValue)
                httpErrorMsg    = "The request failed with http status code of \(statusCodeValue) - \(statusCodeStr)"
                
                if let httpError = error {
                    errorDescription = httpError.localizedDescription
                    httpErrorMsg    += "\n An error occurred with description - \(errorDescription)"
                }
                
                let responseError = NSError(domain: Constants.ErrorDomains.ResponseError, code: 50, userInfo: [NSLocalizedDescriptionKey:httpErrorMsg])
                
                httpData(data,responseError)
                return
            }
            httpData(data,nil)
        }
        dataTask.resume()
    }
}
