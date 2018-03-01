//
//  ParseDataInterface.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import Foundation

protocol ParseDataInterface {
    func parseData(_ jsonData: Data, queue:DispatchQueue, parsedResults: @escaping([CharacterInterface],NSError?)-> Void)
}
