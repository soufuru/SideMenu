//
//  ViewController.swift
//  Menu
//
//  Created by SoichiFurukawa on 2016/12/21.
//  Copyright © 2016年 FurukawaSoichi. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,SideMenuDelegate{

    var sideView : SideMenu!
    @IBOutlet var RightEdgePanGesture: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let imageArray = [UIImage(named:"0.png")!,UIImage(named:"1.png")!,UIImage(named:"2.png")!]
        sideView = SideMenu(image:imageArray, parentViewController:self)
        sideView.delegate = self
        self.view.addSubview(sideView)
        RightEdgePanGesture.edges = .right
    }
    
    func EdgePanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        sideView.EdgePanGesture(sender: sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*  デリゲートメソッド   */
    func onClickButton(sender: UIButton) {
        print(sender.tag)
    }

}
