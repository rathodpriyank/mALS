//
//  NotificationsViewController.swift
//  mALS test
//
//  Created by Joshua Herrera on 7/14/15.
//  Copyright (c) 2015 Joshua Herrera. All rights reserved.
//

import UIKit

protocol NotificationsViewControllerDataSource: class {
//    var firstNameTableCell: String? { get }
//    var lastNameTableCell: String? { get }
//    var roomNum: String? { get }
//    var notificationMessage: String? { get }
//    var time: String? { get }
    
    func getProfileNameForNotificationAtIndex(index: Int) -> (firstName: String?, lastName: String?)
    func getProfileLocationForNotificationAtIndex(index: Int) -> String?
    func getProfileNotificationReceivedAtIndex(index: Int) -> String?
    func getProfileTimeOfNotificationAtIndex(index: Int) -> String?
    func getTotalCountOfNotifications() -> Int?
}

class NotificationsTableViewController: UITableViewController {

    @IBOutlet weak var clearButton: UIButton!
    weak var dataSource: NotificationsViewControllerDataSource?
    
    func updateView() {
        let indexPath = NSIndexPath(forRow: (self.dataSource?.getTotalCountOfNotifications())! - 1 , inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        //self.tableView.reloadData()
    }
    
    @IBAction func clearNotifications(sender: UIButton) {
        arrayOfNotifications.removeAllObjects()
        self.tableView.reloadData()
    }
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
        return (self.dataSource?.getTotalCountOfNotifications())!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MyCellForNotifications", forIndexPath: indexPath) as! MyTableViewCellNotifications
        
        //Cell label names
        // time and payload technique of calling indexPath.row twice will not work. Must rework so its proper
        cell.name.text = (self.dataSource?.getProfileNameForNotificationAtIndex(indexPath.row).firstName)! + " " + (self.dataSource?.getProfileNameForNotificationAtIndex(indexPath.row).lastName)!
        cell.time.text = self.dataSource?.getProfileTimeOfNotificationAtIndex(indexPath.row)
        cell.roomNumber.text = self.dataSource?.getProfileLocationForNotificationAtIndex(indexPath.row)
        cell.payload.text = self.dataSource?.getProfileNotificationReceivedAtIndex(indexPath.row)

        return cell
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
