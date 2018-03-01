//
//  HttpInterface.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import Foundation

protocol HttpInterface {
    func httpGet(forUrl urlStr:String, httpData:@escaping (Data?,NSError?)-> Void)
}
