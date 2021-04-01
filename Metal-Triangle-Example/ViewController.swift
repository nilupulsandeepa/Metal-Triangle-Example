//
//  ViewController.swift
//  Metal-Triangle-Example
//
//  Created by Nilupul Sandeepa on 2021-04-01.
//

import UIKit

class ViewController: UIViewController {
    
    private var metalView: MetalView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Attach Metal View
        self.metalView = MetalView(frame: self.view.frame)
        self.view.addSubview(metalView)
        
        let triButton: UIButton = UIButton()
        triButton.setTitle("Triangle", for: .normal)
        triButton.backgroundColor = UIColor.red
        triButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(triButton)
        triButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.triangle)))
        
        self.view.addConstraint(NSLayoutConstraint(item: triButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.5, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: triButton, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.08, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: triButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: triButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0))
        
        let rectButton: UIButton = UIButton()
        rectButton.setTitle("Rectangle", for: .normal)
        rectButton.backgroundColor = UIColor.blue
        rectButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rectButton)
        rectButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.rectangle)))
        
        self.view.addConstraint(NSLayoutConstraint(item: rectButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.5, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: rectButton, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.08, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: rectButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: rectButton, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0))
    }
    
    @objc func triangle() {
        self.metalView.changeRenderType(to: .Triangle)
    }
    
    @objc func rectangle() {
        self.metalView.changeRenderType(to: .Rectangle)
    }


}

