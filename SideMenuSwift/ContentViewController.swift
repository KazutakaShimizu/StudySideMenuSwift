//
//  ContentViewController.swift
//  SideMenuSwift
//
//  Created by 清水一貴 on 2016/10/04.
//  Copyright © 2016年 清水一貴. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    var ootViewController: RootViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func bootButtonTapped(_ sender: AnyObject) {
        guard let rootViewController = rootViewController() else { return }
        rootViewController.presentMenuViewController()
    }
    
    @IBAction func closeButtonTapped(_ sender: AnyObject) {
        guard let rootViewController = rootViewController() else {return }
        rootViewController.dismissMenuViewController()
    }
    
}
