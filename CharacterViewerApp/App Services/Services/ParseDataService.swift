//
//  ParseDataService.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import Foundation

class ParseDataService: ParseDataInterface {
    
    let queueContainer = QueueContainer.sharedInstance
    
    func parseData(_ jsonData: Data, queue: DispatchQueue, parsedResults: @escaping ([CharacterInterface], NSError?) -> Void) {
        
        queueContainer.parseQueue.async {
            var parseHelper:ParseHelperInterface = ParseHelper(data: jsonData)
            
            parseHelper.completionBlock = {
                queue.async {
                    parsedResults(parseHelper.listOfCharacters, parseHelper.parseError)
                }
            }
            parseHelper.processData()
        }
    }
}
