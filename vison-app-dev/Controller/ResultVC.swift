//
//  ResultVC.swift
//  vison-app-dev
//
//  Created by Apple on 7/15/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    
    var found:String!
    var sore:Int!
    
    @IBOutlet weak var foundResultLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if found != nil{
            foundResultLbl.text  = "You found the \(found!) Timer increase"

        
        }


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CountVC"{
            guard  let destination  = segue.destination as? CountVC else {return}
            destination.score? = 1
            
            
            
        }
        
    }
    
    
    
    @IBAction func nextButtonWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "CountVC", sender: nil)
        
    }
    
   
    
   

}
