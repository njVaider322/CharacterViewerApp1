//
//  CharacterServiceInterface.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import Foundation

protocol CharacterServiceInterface {
    init(api:HttpInterface,parseData:ParseDataInterface)
    func retrieveCharacters(_ uiQueue:DispatchQueue, completion:@escaping([CharacterInterface],NSError?)-> Void)
    func image(forUrl urlStr:String, uiQueue:DispatchQueue, completion:@escaping(Data?,NSError?)-> Void)
    func imageSync(forUrl urlStr:String, uiQueue:DispatchQueue, completion:@escaping(Data?,NSError?)-> Void)
}
