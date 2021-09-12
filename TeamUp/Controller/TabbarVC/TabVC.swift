//
//  TabVC.swift
//  TeamUp
//
//  Created by Apple on 04/09/21.
//

import UIKit

class TabVC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Find My"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    

    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == (self.tabBar.items!)[0]{
            self.title = "Chat"
        }else if item == (self.tabBar.items!)[1]{
            self.title = "Notification"
        }else if item == (self.tabBar.items!)[2]{
            self.title = "Find My"
        }else if item == (self.tabBar.items!)[3]{
            self.title = "Profile"
        }else if item == (self.tabBar.items!)[4]{
            self.title = "Settings"
        }
    }
    
    
}


