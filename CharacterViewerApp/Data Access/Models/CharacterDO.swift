//
//  CharacterDO.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import UIKit
import Foundation

class CharacterDO: CharacterInterface {
    var characterID   = 0
    var name          = ""
    var characterDesc = ""
    var imageUrl      = ""
    var isImageLoaded = false
    var photo: UIImage?
    
    var text: String {
        get {return ""}
        set(tempValue) {
            let tempArray = tempValue.components(separatedBy: " - ")
            
            for strValue in tempArray {
                if name.count == 0 {
                    name = strValue
                }
                else {
                    characterDesc = strValue
                }
            }
            name = tempArray[0]
            characterDesc = tempArray[1]
        }
    }
}
