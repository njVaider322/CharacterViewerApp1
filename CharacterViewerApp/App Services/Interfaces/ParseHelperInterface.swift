//
//  ParseHelperInterface.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import Foundation

protocol ParseHelperInterface {
    func processData()-> Void
    var completionBlock: (() -> Void)?         { get set }
    var listOfCharacters: [CharacterInterface] { get set }
    var parseError: NSError?                   { get set }
}
