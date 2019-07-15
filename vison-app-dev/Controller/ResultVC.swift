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
    
    @IBOutlet weak var foundResultLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if found != nil{
            foundResultLbl.text  = "You found the \(found!) Timer increase"

        
        }


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
