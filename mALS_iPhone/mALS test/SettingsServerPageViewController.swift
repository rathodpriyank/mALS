//
//  SettingsServerPageViewController.swift
//  mALS test
//
//  Created by Joshua Herrera on 7/28/15.
//  Copyright (c) 2015 Joshua Herrera. All rights reserved.
//

import UIKit

protocol SettingsServerPageViewControllerDataSource: class {
    
    
}

class SettingsServerPageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var controllers = [UIViewController]()
    var index = 0
    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsServerPageViewController") as! UIPageViewController
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        controllers.append(storyboard?.instantiateViewControllerWithIdentifier("SettingsPage1") as! UIViewController)
        self.pageViewController.setViewControllers(controllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        controllers.append(storyboard?.instantiateViewControllerWithIdentifier("SettingsPage2") as! UIViewController)
        controllers.append(storyboard?.instantiateViewControllerWithIdentifier("SettingsPage3") as! UIViewController)
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if(index >= (controllers.count - 1)) {
            return nil
        }
        return self.controllers[++index]
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if(index == 0 || index == NSNotFound) {
            return nil
        }
        return controllers[--index]
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        return nil
    }
}
