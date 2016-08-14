//
//  ConfigPageViewController.swift
//  mALS test
//
//  Created by Joshua Herrera on 7/14/15.
//  Copyright (c) 2015 Joshua Herrera. All rights reserved.
//

import UIKit
import Foundation


class MainCollectionViewController: UICollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource, NotificationsViewControllerDataSource, ManagerTableViewControllerDataSource,  SettingsClientViewControllerDataSource, SettingsServerViewControllerDataSource {

    // Brain
    var brain = mALSBrain()
    
    // For storyboard initialization of Cells in collection
    var reuseIdentifier = String()
    
    // Cell image and name associated task. Example: Notifications, Alert, etc
    var cellNames = [String]()
    var cellImages = [String]()
    var seguePath = [String]()
    var nextViewController = [UIViewController]()

    
    // Satisfies protocols for ManagerTableViewControllerDataSource and NotificationsTableViewControllerDataSource
    // numberOfProfiles() also satisfies the protocol for SerttingsServerViewControllerDataSource
    
    func numberOfProfiles() -> Int? {
        return brain.getProfileCount()
    }
    func getProfileNameForNotificationAtIndex(index: Int) -> (firstName: String?, lastName: String?) {
        return (brain.getNotificationInfoAtIndex(index)?.getNotificationInfo().firstName, brain.getNotificationInfoAtIndex(index)?.getNotificationInfo().lastName)
    }
    func getProfileLocationForNotificationAtIndex(index: Int) -> String? {
        return brain.getNotificationInfoAtIndex(index)?.getNotificationInfo().location
    }
    func getProfileNotificationReceivedAtIndex(index: Int) -> String? {
        return brain.getNotificationInfoAtIndex(index)?.getNotificationInfo().payload
    }
    func getProfileTimeOfNotificationAtIndex(index: Int) -> String? {
        return brain.getNotificationInfoAtIndex(index)?.getNotificationInfo().timeRecieved
    }
    func getTotalCountOfNotifications() -> Int? {
        return brain.getNumberOfNotifications()
    }
    
    func getProfileInfoAtIndex(index: Int) -> (firstName: String, lastName: String, location: String){
            return (brain.getProfileInfoAtIndex(index).firstName , brain.getProfileInfoAtIndex(index).lastName, brain.getProfileInfoAtIndex(index).location)
    }
    
    // Satisfies protocols for SettingsViewControllerDataSource
    
    
    // Satisfies protocols for SettingsServerViewControllerDataSource
    var ssid: String? = ""
    var securityType: String? = ""
    var password: String? = ""
    var deviceId: String? = "None"
    var firstNameConfig: String? = ""
    var lastNameConfig: String? = ""
    var location: String? = ""
    var host: String? = "sparkstech.cloudapp.net"
    var port: Int? = 1883
    var age = 20
    
    func isConnectedToDevice() -> Bool {
        return self.brain.isConnected()
    }
    
    func addProfile() {
        self.brain.addProfile(firstNameConfig!, lastName: lastNameConfig!, host: host, port: port!, age: age, location: location!, ssid: ssid!, securityType: securityType!, password: password!)
    }
    
    func removeProfile() {
        self.brain.removeProfile(0)
    }
    
    func resetVariables() {
        self.ssid = ""
        self.securityType = ""
        self.password = ""
        self.firstNameConfig = ""
        self.lastNameConfig = ""
        self.location = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The view controllers are initialized in this order due to how the cells get created. The cells get created going from top to bottom then switching over to the next column. so


        // Can be anything as long is it is the same as the Collection Cell name in storyboard
        // Prototype cell name in the storyboard
        reuseIdentifier = "MyCell"
        
        // Task for each cell, can be customized later on if we want to add more or remove. The reason the names are set in this order for each cell is the same reasoning as the comment above for the view controllers
        // Images for each cell need to be parallel with cellNames[]
        cellNames = ["Notifications", "Configuration"]
        //cellNames = ["Notifications", "Manager", "Configuration"]
        cellImages = ["an_icon.png", "Settings-icon copy.png"]
        //cellImages = ["ECS-logo-cmyk.jpg","ECS-logo-cmyk.jpg","ECS-logo-cmyk.jpg"]
        
        // Generates segues to UIViewControllers based off of the above parallel arrays
        seguePath = ["segueNotifications", "segueConfiguration"]
        //seguePath = ["segueNotifications", "segueManager", "segueConfiguration"]


        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var numberOfCellInRow : Int = 2
        var padding : Int = 20
        var collectionCellWidth : CGFloat = (self.view.frame.size.width/CGFloat(numberOfCellInRow)) - CGFloat(padding)
        return CGSize(width: collectionCellWidth , height: collectionCellWidth)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellNames.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
        
        // Configure the cell image and label
        
        // Image will be the task picture. So configuration will have picture of a gear
        cell.imageView.image = UIImage(named: cellImages[indexPath.row])
        cell.imageView.sizeToFit()
        cell.collectionCellName.text = cellNames[indexPath.row]
        
        // Make systemFontOfSize be set to the max value possible of the smallest one.
        cell.collectionCellName.font = UIFont.systemFontOfSize(16)
        cell.collectionCellName.enabled = true
       // cell.systemLayoutSizeFittingSize(self.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAtIndexPath: indexPath))

        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell \(indexPath.row) selected")
        // Use prepareForSegue
        self.performSegueWithIdentifier(seguePath[indexPath.row], sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        // Might need to specify which type of view controller im segue'ing to
        switch segue.identifier! {
        case "segueNotifications":
            if let nvc = destination as? NotificationsTableViewController {
                nvc.dataSource = self
                brain.setCurrentViewController(nvc)
            }
        case "segueManager":
            if let mvc = destination as? ManagerTableViewController {
                mvc.dataSource = self
                brain.setCurrentViewController(mvc)
            }
        case "segueConfiguration":
            if let svc = destination as? SettingsTabViewController {
                svc.dataSource = self
                let test = destination as? SettingsServerViewController
                brain.setCurrentViewController(test)
            }
        default:
            NSLog("Messed up somewhere\n")
            break
        }
    }

    override func viewDidDisappear(animated: Bool) {

    }
    


    // Possible set up a prepareForSegue to transition from CollectionView Controller to UIViewController
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    

}



