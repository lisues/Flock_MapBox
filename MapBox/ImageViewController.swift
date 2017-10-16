//
//  ViewController.swift
//  MapBox
//
//  Created by Lisue Jocelyn She on 10/16/17.
//  Copyright © 2017 Lisue Jocelyn She. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    
    @IBOutlet weak var hello: UILabel!

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hello.isHidden = true
    }
    
    @IBAction func dismissed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageButton(_ sender: Any) {
        hello.isHidden = false
        hello.text = "Hellow World!!"

    }
}
