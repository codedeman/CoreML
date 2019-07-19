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
    
    @IBOutlet weak var imageView: UIImageView?{
        didSet{

        }
    }
    @IBOutlet weak var foundResultLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if found != nil{
            foundResultLbl.text  = "You found the \(found!) Timer increase"
        }
        
        if image != nil{
            let size = CGSize(width: 30.0, height: 30.0)
            imageView?.image = imageResize(image: image!, sizeChange: size)
        }


    }
    
    func imageResize (image:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "CountVC"{
//            guard  let destination  = segue.destination as? CountVC else {return}
////                destination.score? = 1
////            let c = destination.score
//            
//            
//            
//        }
//        
//    }
    
    
    
    @IBAction func nextButtonWasPressed(_ sender: Any) {
        
        
        guard let countVC = storyboard?.instantiateViewController(withIdentifier: "CountVC") as? CountVC else { return }
        let total = sore
        
        countVC.score = total
        
        
        present(countVC, animated:true, completion: nil)
        
        
        
        
    }
    
   
    
   

}
