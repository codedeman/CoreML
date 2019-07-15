//
//  FinishGameVC.swift
//  vison-app-dev
//
//  Created by Apple on 7/11/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class FinishGameVC: UIViewController {

    var found:String!
    @IBOutlet weak var foundResultLbl: UILabel!
    
    @IBAction func nextRoundBtn(_ sender: Any) {
//        performSegue(withIdentifier: "CountVC" , sender: self)

        presentDetail()
//        let nexRound = CountVC()
//        nexRound.modalTransitionStyle = .coverVertical
//        nexRound.modalPresentationStyle = .overCurrentContext
//        self.present(nexRound, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foundResultLbl.text  = "You found the \(found!) Timer increase"
        

        // Do any additional setup after loading the view.
    }
    
    func presentDetail() {
        let nexRound = CountVC()
        
//        nexRound.countLabel?.isHidden = false
//        nexRound.backgroundResult?.isHidden = false
//        nexRound.count = 3
        

//        guard let nexRound = storyboard?.instantiateViewController(withIdentifier: "CountVC") as? CountVC else { return }
        
        
//        nexRound.inputPridiction = predict
        
        present(nexRound, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CountVC"{
            guard let destination  = segue.destination as? CountVC else{return}
            
        }
    }


 
}
