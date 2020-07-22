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

        let collectionVC = CollectionView()
        
        collectionVC.tabBarItem = UITabBarItem(title: "Коллекция", image: UIImage(named: "collection"), tag: 0)
        
        let favoriteVC = FavoriteViewController()
        favoriteVC.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(named: "favorite"), tag: 1)
        
        let cameraVC = ImagePickerView()
        cameraVC.tabBarItem = UITabBarItem(title: "Камера", image: UIImage(named: "camera"), tag: 2)
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "settings"), tag: 3)
        
        let tabBarList = [collectionVC, favoriteVC, cameraVC, settingsVC]
        
        viewControllers = tabBarList.map() {
            let controller = UINavigationController(rootViewController: $0)
            controller.isNavigationBarHidden = true
            return controller
        }
    }
}
