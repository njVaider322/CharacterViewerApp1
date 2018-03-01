//
//  CharacterModel.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import UIKit
import Foundation

protocol CharacterModelDidChangedDelegate {
    func characterModelDidChanged()->Void
}

class CharacterModel: CharacterModelInterface {
    
    var characterCollection = [CharacterInterface]()
    var delegate: CharacterModelDidChangedDelegate?
    
    fileprivate let queueContainer = QueueContainer.sharedInstance
    fileprivate let characterService: CharacterServiceInterface?
    
    init() {
        characterService = CharacterService(api: HttpService(), parseData: ParseDataService())
    }
    
    func initializeModel()-> Void {
        
        characterService?.retrieveCharacters(queueContainer.userInterfaceQueue, completion: { (characters, error) in
            guard error == nil else {
                
                return
            }
            
            self.characterCollection.removeAll()
            self.characterCollection.append(contentsOf: characters)
            
            if self.delegate != nil {
                self.delegate!.characterModelDidChanged()
            }
        })
    }
    
    func loadPhoto(forCharacter characterDO:CharacterInterface, completion:@escaping(UIImage,NSError?)-> Void)-> Void {
        
        characterService?.imageSync(forUrl: characterDO.imageUrl,
                                    uiQueue: queueContainer.userInterfaceQueue,
                                    completion: { (data, error) in
                                        guard error == nil else {
                                            return
                                        }
                                        let photo = UIImage(data: data!)
                                        completion(photo!, nil)
        })
    }
}

