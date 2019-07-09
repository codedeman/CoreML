//
//  Category.swift
//  vison-app-dev
//
//  Created by Apple on 7/8/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import Foundation
import Firebase
struct Category {
    var icon:String
    var imageUrl:String
    var name:String
    init(icon:String,imageUrl:String,name:String) {
        self.icon = icon
        self.imageUrl = imageUrl
        self.name = name
    }
    init(data:[String:Any]) {
        
        self.icon = data["icon"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.name =  data["name"] as? String ?? ""
        
    }
}
