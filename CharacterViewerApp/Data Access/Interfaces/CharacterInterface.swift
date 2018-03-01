//
//  CharacterInterface.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import UIKit
import Foundation

protocol CharacterInterface {
    var characterID:Int      {get set}
    var name:String          {get set}
    var characterDesc:String {get set}
    var imageUrl:String      {get set}
    var isImageLoaded:Bool   {get set}
    var photo:UIImage?       {get set}
    var text: String         {get set}
}
