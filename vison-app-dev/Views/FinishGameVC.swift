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
        let nexRound = CountVC()
        nexRound.modalTransitionStyle = .coverVertical
        nexRound.modalPresentationStyle = .overCurrentContext
        self.present(nexRound, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foundResultLbl.text  = "You found the \() Timer increase"

        // Do any additional setup after loading the view.
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
