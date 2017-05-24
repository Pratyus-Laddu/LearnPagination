//
//  PageContentViewController.swift
//  PagenavigationExample
//
//  Created by Pratyus P on 24/05/17.
//  Copyright © 2017 Pratyus P. All rights reserved.
//

import UIKit
/*
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}*/


class PageContentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var pageIndex: Int!
    var imageUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string:imageUrl)
        let data = try? Data(contentsOf: url!)
        if (data?.count)! > 0  {
            self.imageView.image = UIImage(data:data!)
        }
    }

}
