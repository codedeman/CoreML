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
//        nexRound.count = 3
        

//        guard let nexRound = storyboard?.instantiateViewController(withIdentifier: "CountVC") as? CountVC else { return }
        
        
//        nexRound.inputPridiction = predict
        
        present(nexRound, animated: true, completion: nil)
        
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
