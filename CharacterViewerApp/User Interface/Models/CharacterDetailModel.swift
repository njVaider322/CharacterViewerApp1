//
//  CharacterDetailModel.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import UIKit
import Foundation

protocol CharacterDetailModelDidChangedDelegate {
    func detailModelDidChanged()->Void
}

class CharacterDetailModel {
    
    var characterDO:CharacterInterface?
    var delegate: CharacterDetailModelDidChangedDelegate?
    
    fileprivate let queueContainer = QueueContainer.sharedInstance
    fileprivate let characterService: CharacterServiceInterface?
    
    init() {
        characterService = CharacterService(api: HttpService(), parseData: ParseDataService())
    }
    
    func upDatePhoto()->Void {
        
        var url = ""
        
        if let tempUrl = characterDO?.imageUrl {
            url = tempUrl
        }
        
        if url.count == 0 {
            return
        }
        
        characterService?.image(forUrl: url, uiQueue: queueContainer.userInterfaceQueue, completion: { (data, error) in
            
            guard error == nil else {
                
                return
            }
            
            let photo = UIImage(data: data!)
            
            self.characterDO?.photo         = photo
            self.characterDO?.isImageLoaded = true
            
            if self.delegate != nil {
                self.delegate!.detailModelDidChanged()
            }
        })
    }
}
