//
//  SideMenu.swift
//  Menu
//
//  Created by SoichiFurukawa on 2016/12/21.
//  Copyright © 2016年 FurukawaSoichi. All rights reserved.
//

import UIKit


@objc protocol SideMenuDelegate {
    func onClickButton(sender:UIButton)
}

class SideMenu: UIView {
    var size: CGRect?
    var swipeGesture : UISwipeGestureRecognizer!
    var rightConstraint: NSLayoutConstraint!
    var parentVC: UIViewController!
    var isSideMenuhidden: Bool = true
    
    private weak var delegate: SideMenuDelegate?
    
    init(image: [UIImage],
         parentViewController: UIViewController,
         delegate: SideMenuDelegate
    ) {
        self.size = CGRect(x:UIScreen.main.bounds.width,
                           y:0,
                           width:UIScreen.main.bounds.width*2,
                           height:UIScreen.main.bounds.height
        )
        self.delegate = delegate
        super.init(frame: size!)
        //サイドメニューの背景色
        self.backgroundColor = UIColor.darkGray
        //サイドメニューの背景色の透過度
        self.alpha = 0.8
        self.buttonSet(num: image.count,image: image)
        
        self.parentVC = parentViewController

        //親ビューをタップしたときにメニューを下げる
        let clearView =
            UIView(frame:CGRect(x:0,y:0,
                    width:UIScreen.main.bounds.width*2/3,
                    height:UIScreen.main.bounds.height
                    ))
        clearView.alpha = 1.0
        parentVC.view.addSubview(clearView)
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(self.clearViewTapped)
        )
        tapGesture.numberOfTapsRequired = 1
        clearView.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func clearViewTapped(){
        if isSideMenuhidden == false {
            isSideMenuhidden = true
            UIView.animate(withDuration: 0.8,
                           animations: {
                            self.frame.origin.x = UIScreen.main.bounds.width
            },
                           completion:nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //親ビューで指定した画像の数だけボタンを生成、配置
    func buttonSet(num:Int, image:[UIImage]){
        for i in 0..<num{
            let button =
                UIButton(frame:CGRect(x:10,
                                      y:50+110*i,
                                      width:90, height:90))
            //ボタンの画像
            button.setImage(image[i], for: .normal)
            //ボタンの四隅に余白をつける
            button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            //ボタンの背景色
            button.backgroundColor = UIColor.yellow
            // サイズの半分の値 (丸いボタンにするため)
            button.layer.cornerRadius = 45
            //ボタンにタグをつける
            button.tag = i
            button.addTarget(self,
                             action: #selector(self.onClickButton(sender:)),
                             for: .touchUpInside)
            self.addSubview(button)
        }
    }
    
     //画面の端からのスワイプを検出
    public func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        //移動量を取得する。
        let move:CGPoint = sender.translation(in: parentVC.view)
        
        //画面の端からの移動量
        self.frame.origin.x += move.x
        //画面表示を更新する。
        self.layoutIfNeeded()
        
        //ドラッグ終了時の処理
        if sender.state == UIGestureRecognizer.State.ended {
            if self.frame.origin.x < parentVC.view.frame.size.width/3 {
                //ドラッグの距離が画面幅の三分の一を超えた場合はメニューを出す
                UIView.animate(withDuration: 0.8,
                               animations: { self.frame.origin.x = UIScreen.main.bounds.width*2/3 },
                               completion:nil)
                isSideMenuhidden = false
            } else {
                //ドラッグの距離が画面幅の半分以下の場合はそのままビューを右に戻す。
                UIView.animate(withDuration: 0.8,
                               animations: { self.frame.origin.x = UIScreen.main.bounds.width },
                               completion:nil)
            }
        }
        //移動量をリセットする。
        sender.setTranslation(CGPoint.zero, in: parentVC.view)
    }
    
    @objc func onClickButton(sender: UIButton){
        self.delegate?.onClickButton(sender: sender)
    }
}
