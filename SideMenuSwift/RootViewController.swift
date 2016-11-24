//
//  RootViewController.swift
//  SideMenuSwift
//
//  Created by 清水一貴 on 2016/10/04.
//  Copyright © 2016年 清水一貴. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    var menuViewController: UIViewController!
    var contentViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuViewController = MenuViewController()
        self.contentViewController = ContentViewController()
        
        self.addChildViewController(menuViewController)
        self.view.addSubview(self.menuViewController.view)
        self.menuViewController.didMove(toParentViewController: self)
        
        self.addChildViewController(contentViewController)
        self.view.addSubview(self.contentViewController.view)
        self.contentViewController.didMove(toParentViewController: self)
        
//        この段階でrootViewには他の二枚のビューが重なっている状態
        
//        ビューをhiddenにする。コンテントビューが表示される
        self.menuViewController.view.isHidden = true
//        subViewの順番を変更する。この場合、menuViewを一番前に持ってきている。子ビューの登録順序を変えれればここは要らない
        self.view.bringSubview(toFront: self.menuViewController.view)
        
    }
    
    // メニューViewControllerの表示
    func presentMenuViewController(){
//        子ビューコントローラーが表示されるのを通知する
        menuViewController.beginAppearanceTransition(true, animated: true)
        self.menuViewController.view.isHidden = false
//        dxをマイナスでセットしておかないと、メニューが逆側から飛び出してきてしまう
        self.menuViewController.view.frame = menuViewController.view.frame.offsetBy(dx: -menuViewController.view.frame.size.width, dy: 0)
//        dumpingratioが低いほど、メニューが荒々しく飛び出してくる
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
//            ここでアニメーションした後どういう状態になっているかを定義する
            let bounds = self.menuViewController.view.bounds
//            menuViewControllerの幅の半分の位置にx座標を持ってくる。ビューの高さと幅は変えない
            self.menuViewController.view.frame = CGRect(x:-bounds.size.width / 2, y:0, width:bounds.size.width, height:bounds.size.height)
            }, completion: {_ in
//                子ビューの表示終了を通知
                self.menuViewController.endAppearanceTransition()
        })
    }
    
    // メニューViewControllerの非表示
    func dismissMenuViewController(){
        self.menuViewController.beginAppearanceTransition(false, animated: true)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.menuViewController.view.frame = self.menuViewController.view.frame.offsetBy(dx: -self.menuViewController.view.bounds.size.width / 2, dy: 0)
            }, completion: {_ in
                self.menuViewController.view.isHidden = true
                self.menuViewController.endAppearanceTransition()
        })
    }
    
}

//全てのビューコントローラーから、親ビューをたどってrootViewControllerを探すメソッド
extension UIViewController{
    func rootViewController() -> RootViewController? {
//        自分自信の親ビューを取得
        var vc = self.parent
        while (vc != nil) {
            guard let viewController = vc else {return nil }
//            親ビューがrootviewcontrollerだったら、そのビューを返す
            if viewController is RootViewController {
                return viewController as? RootViewController
            }
            vc = viewController.parent
        }
        return nil
    }
}
