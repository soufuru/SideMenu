//
//  ViewController.swift
//  Menu
//
//  Created by SoichiFurukawa on 2016/12/21.
//  Copyright © 2016年 FurukawaSoichi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var sideView: SideMenu?
    @IBOutlet var rightEdgePanGesture: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let imageArray = [UIImage(named:"0.png")!, UIImage(named:"1.png")!, UIImage(named:"2.png")!]
        let sideView = SideMenu(image:imageArray, parentViewController:self, delegate: self)
        self.view.addSubview(sideView)
        self.sideView = sideView
        
        rightEdgePanGesture.edges = .right
    }
    
    @IBAction func edgePanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        sideView?.edgePanGesture(sender: sender)
    }
}

extension ViewController: SideMenuDelegate {
    func onClickButton(sender: UIButton) {
        print(sender.tag)
    }
}
