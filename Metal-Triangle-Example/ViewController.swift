//
//  ViewController.swift
//  Metal-Triangle-Example
//
//  Created by Nilupul Sandeepa on 2021-04-01.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Attach Metal View
        let metalView: MetalView = MetalView(frame: self.view.frame)
        self.view.addSubview(metalView)
    }


}

