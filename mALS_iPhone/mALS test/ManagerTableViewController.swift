//
//  AlertsViewController.swift
//  mALS test
//
//  Created by Joshua Herrera on 7/17/15.
//  Copyright (c) 2015 Joshua Herrera. All rights reserved.
//

import UIKit

protocol ManagerTableViewControllerDataSource: class {
    // Variables needed
    // Functions needed
    func numberOfProfiles() -> Int?
    func getProfileInfoAtIndex(index: Int) -> (firstName: String, lastName: String, location: String)
}

class ManagerTableViewController: UITableViewController{
    
    weak var dataSource: ManagerTableViewControllerDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return (dataSource?.numberOfProfiles())!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MyCellForManager", forIndexPath: indexPath) as! MyTableViewCellForManager
        
        //Config Cell
        cell.nameLabel.text = (self.dataSource?.getProfileInfoAtIndex(indexPath.row).firstName)! + " " + (self.dataSource?.getProfileInfoAtIndex(indexPath.row).lastName)!
        cell.infoButton.hidden = false
        cell.alertsButton.hidden = false
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //performSegueWithIdentifier("segueModifyProfile", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let cvc = destination as? SettingsTabViewController {
            cvc.dataSource = self
        }
        
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
