//
//  BadgeViewController.swift
//  PagenavigationExample
//
//  Created by Pratyus P on 24/05/17.
//  Copyright © 2017 Pratyus P. All rights reserved.
//
import UIKit

class BadgeViewController: UIViewController {
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        index = (sender as! UIButton).tag
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
        
    }
}
