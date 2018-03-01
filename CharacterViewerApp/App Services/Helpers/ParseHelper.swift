//
//  ParseHelper.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import Foundation

class ParseHelper:ParseHelperInterface {
    
    var httpData: Data?
    var completionBlock: (() -> Void)?
    var parseError: NSError?
    
    var parsedData       = [String:Any]()
    var listOfCharacters = [CharacterInterface]()
    
    init(data:Data?) {
        httpData = data
    }
    
    func processData()-> Void {
        var relatedTopics = [[String:Any]]()
        var count = 1
        
        do {
            parsedData = try JSONSerialization.jsonObject(with: httpData!, options: .mutableContainers) as! Dictionary<String,Any>
            relatedTopics.append(contentsOf: parsedData["RelatedTopics"] as! Array<Dictionary<String,Any>>)
            
            for jsonData in relatedTopics {
                var characterDO: CharacterInterface = CharacterDO()
                
                characterDO.characterID   = count
                characterDO.isImageLoaded = false
                characterDO.text          = jsonData["Text"] as! String
                
                let iconDictionary = jsonData["Icon"] as! [String:String]
                
                if let imageLocation = iconDictionary["URL"] {
                    characterDO.imageUrl = imageLocation
                }
                else {
                    characterDO.imageUrl = ""
                }
                count += 1
                listOfCharacters.append(characterDO)
            }
            
            if completionBlock != nil {
                completionBlock!()
            }
        }
        catch let error {
            parseError = NSError(domain: Constants.ErrorDomains.JSONParseErrors, code: 50, userInfo: [NSLocalizedDescriptionKey:error.localizedDescription])
            if completionBlock != nil {
                completionBlock!()
            }
        }
    }
}
