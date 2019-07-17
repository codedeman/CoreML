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
    var image:UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var foundResultLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if found != nil{
            foundResultLbl.text  = "You found the \(found!) Timer increase"
        }
        
        if image != nil{
            imageView.image  = image
        }


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CountVC"{
            guard  let destination  = segue.destination as? CountVC else {return}
//                destination.score? = 1
//            let c = destination.score
            
            
            
        }
        
    }
    
    
    
    @IBAction func nextButtonWasPressed(_ sender: Any) {
        
        
        guard let countVC = storyboard?.instantiateViewController(withIdentifier: "CountVC") as? CountVC else { return }
        let total = sore
        
        countVC.score = total
        
        
        present(countVC, animated:true, completion: nil)
        
//        performSegue(withIdentifier: "CountVC", sender: nil)
        
        
        
    }
    
   
    
   

}
