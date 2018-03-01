//
//  QueueContainer.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import Foundation

class QueueContainer {
    
    static let sharedInstance = QueueContainer()
    
    let parseQueue         = DispatchQueue(label: Constants.QueueNames.Parse, qos: .utility)
    let appServicesQueue   = DispatchQueue(label: Constants.QueueNames.AppServices, attributes: .concurrent)
    let userInterfaceQueue = DispatchQueue.main
    
    fileprivate init() {
    }
}
