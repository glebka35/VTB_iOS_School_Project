//
//  MainTabBarController.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 03.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionVC = CollectionViewController()
        
        collectionVC.tabBarItem = UITabBarItem(title: "Коллекция", image: UIImage(named: "tray"), tag: 0)
        
        let favoriteVC = FavoriteViewController()
        favoriteVC.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(named: "heart"), tag: 1)
        
        
        let cameraVC = CameraViewController()
        cameraVC.tabBarItem = UITabBarItem(title: "Камера", image: UIImage(named: "camera"), tag: 2)
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "gear"), tag: 3)
        
        let tabBarList = [collectionVC, favoriteVC, cameraVC, settingsVC]
        
        viewControllers = tabBarList.map {
            UINavigationController(rootViewController: $0)
        }
    }
}
