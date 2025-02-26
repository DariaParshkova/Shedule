//
//  ViewController.swift
//  Shedule
//
//  Created by Parshkova Daria on 07.07.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        //эта функция вызывает все viewControllers
        let scheduleViewController = createNavController(vc: SheduleViewControllerSheduleViewController(), itemName: "Shedule", itemImage: "calendar.badge.clock")
        let tasksViewController = createNavController(vc: TasksViewController(), itemName: "Tasks", itemImage: "text.badge.checkmark")
        let contactsViewController = createNavController(vc: ContactsViewController(), itemName: "Contacts", itemImage: "rectangle.stack.person.crop")
        viewControllers = [scheduleViewController, tasksViewController, contactsViewController]
    }

    func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10) //опускаем title у item
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance //полоска навигации
        return navController
        
    }

}

