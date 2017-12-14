//
//  UserscoreData.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 13-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//

import Foundation
import FirebaseDatabase

// Used to store userscores from database.
struct Userscore {
    let username: String
    let score: Int
    
    init(snapshot: DataSnapshot) {
        username = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        score = snapshotValue["score"] as! Int
    }
}
