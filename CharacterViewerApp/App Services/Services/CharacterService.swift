//
//  CharacterService.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import Foundation

class CharacterService: CharacterServiceInterface {
    
    private let httpService: HttpInterface
    private let parseDataService: ParseDataInterface
    
    private let queueContainer = QueueContainer.sharedInstance
    
    var isWorking = false
    
    required init(api: HttpInterface, parseData: ParseDataInterface) {
        httpService      = api
        parseDataService = parseData
    }
    
    func retrieveCharacters(_ uiQueue: DispatchQueue, completion: @escaping ([CharacterInterface], NSError?) -> Void) {
        
        httpService.httpGet(forUrl: Constants.Urls.Url) { (data, error) in
            
            guard let httpData = data, error == nil else {
                uiQueue.async {
                    completion([CharacterInterface](),error)
                }
                return
            }
            
            self.parseDataService.parseData(httpData, queue: self.queueContainer.appServicesQueue, parsedResults: { (resultsArray, error) in
                
                guard error == nil else {
                    uiQueue.async {
                        completion(resultsArray,error)
                    }
                    return
                }
                
                uiQueue.async {
                    completion(resultsArray, error)
                }
            })
        }
    }
    
    func image(forUrl urlStr: String, uiQueue: DispatchQueue, completion: @escaping (Data?, NSError?) -> Void) {
        
        httpService.httpGet(forUrl: urlStr) { (data, error) in
            
            guard let imageData = data, error == nil else {
                uiQueue.async {
                    completion(data,error)
                }
                return
            }
            uiQueue.async {
                completion(imageData,error)
            }
        }
    }
    
    func imageSync(forUrl urlStr:String, uiQueue:DispatchQueue, completion:@escaping(Data?,NSError?)-> Void) {
        
        isWorking = true
        
        httpService.httpGet(forUrl: urlStr) { (data, error) in
            
            guard let imageData = data, error == nil else {
                uiQueue.async {
                    completion(data,error)
                }
                self.isWorking = false
                return
            }
            uiQueue.async {
                completion(imageData,error)
            }
            self.isWorking = false
        }
        
        let timeOut = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(CharacterService.operationHasTimedOut), userInfo: nil, repeats: false)
        
        while isWorking {
            Thread.sleep(forTimeInterval: 0.3)
        }
        timeOut.invalidate()
    }
    
    @objc fileprivate func operationHasTimedOut() {
        isWorking = false
    }
}

