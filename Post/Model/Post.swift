//
//  Post.swift
//  Post
//
//  Created by Xavier on 10/15/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation


struct Post: Codable {
    var text: String
    var username: String
    var timestamp: TimeInterval
    
    init(text: String, username: String, timestamp: TimeInterval = Date().timeIntervalSince1970) {
        self.text = text
        self.username = username
        self.timestamp = timestamp
    }
    
//    var queryTimestamp: String {
//
//    }
}
