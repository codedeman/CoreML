//
//  FeedVC.swift
//  vison-app-dev
//
//  Created by Apple on 7/5/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

import AVFoundation

class FeedVC: UIViewController {
    var speechSynthesizer = AVSpeechSynthesizer()

    @IBOutlet weak var nameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        synthesizeSpeech(fromString: "Click play button to play this game")
        // Do any additional setup after loading the view.
    }
    
    func synthesizeSpeech(fromString string: String) {
        let speechUtterance = AVSpeechUtterance(string: string)
        speechSynthesizer.speak(speechUtterance)
    }
    

   

}

