//
//  ConfigPage1.swift
//  mALS test
//
//  Created by Joshua Herrera on 7/14/15.
//  Copyright (c) 2015 Joshua Herrera. All rights reserved.
//

import UIKit

class SettingsTabViewController: UITabBarController {

    weak var dataSource: AnyObject?
    var currentViewController: [UIViewController] = []
    
    func setDataSourceForCurrentViewController(title: String?) {
        currentViewController = self.viewControllers as! [UIViewController]
        println("\(currentViewController[0].title)")
        println("\(currentViewController[1].title)")
        if(title == "Sensor") {
            let svc = currentViewController[0] as? SettingsServerViewController
            svc?.dataSource = (self.dataSource as! SettingsServerViewControllerDataSource)
        }
        else if(title == "Buzzer") {
            let bvc = currentViewController[1] as? SettingsClientViewController
            bvc?.dataSource = (self.dataSource as! SettingsClientViewControllerDataSource)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

    }

    override func viewDidAppear(animated: Bool) {
        if(self.selectedViewController!.title == "Sensor Settings") {
            let fvc = self.selectedViewController as! SettingsServerViewController
            fvc.dataSource = self.dataSource as? SettingsServerViewControllerDataSource
            fvc.updateLabels()
        }
        else {
            let fvc = self.selectedViewController as! SettingsClientViewController
            fvc.dataSource = self.dataSource as? SettingsClientViewControllerDataSource
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        setDataSourceForCurrentViewController(item.title)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
