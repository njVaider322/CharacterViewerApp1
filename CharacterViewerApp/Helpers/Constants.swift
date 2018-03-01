//
//  Constants.swift
//  CharacterViewerApp
//
//  Created by Nate Jackson on 2/28/18.
//  Copyright © 2018 Nate Jackson. All rights reserved.
//

import Foundation

struct Constants {
    struct Urls {
        static let Url = "http://api.duckduckgo.com/?q=seinfeld+characters&format=json"
    }
    
    struct QueueNames {
        static let Parse         = "com.CodeTestApp.CTParseQueue"
        static let AppServices   = "com.CodeTestApp.CTAppServicesQueue"
        static let UserInterface = "com.CodeTestApp.CTUserInterfaceQueue"
    }
    
    struct HttpMethods {
        static let Get  = "Get"
        static let Post = "Post"
        static let Put  = "Put"
    }
    
    struct ErrorDomains {
        static let ResponseError   = "com.CodeTestApp.Errors"
        static let JSONParseErrors = "com.CodeTestApp.JSON.Parse.Errors"
    }
}
