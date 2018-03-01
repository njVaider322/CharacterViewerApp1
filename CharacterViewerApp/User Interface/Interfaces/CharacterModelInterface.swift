//
//  CharacterModelInterface.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import UIKit
import Foundation

protocol CharacterModelInterface {
    
    var characterCollection:[CharacterInterface] {get set}
    var delegate:CharacterModelDidChangedDelegate? {get set }
    func initializeModel()-> Void
    func loadPhoto(forCharacter characterDO:CharacterInterface, completion:@escaping(UIImage,NSError?)-> Void)
    
}
