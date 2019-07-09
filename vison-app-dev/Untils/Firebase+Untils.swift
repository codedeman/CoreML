//
//  Firebase+Untils.swift
//  vison-app-dev
//
//  Created by Apple on 7/8/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import Firebase
extension Firestore{
    
    var categories: Query {
        return collection("categories").order(by: "timeStamp", descending: true)
    }
}
