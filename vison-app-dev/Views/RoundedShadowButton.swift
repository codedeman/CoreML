//
//  RoundedShadowButton.swift
//  vison-app-dev
//
//  Created by Kien on 12/11/18.
//  Copyright © 2018 Kien. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {

    override func awakeFromNib() {
//        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 0.1
//        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = 15
        
    }
   

}
