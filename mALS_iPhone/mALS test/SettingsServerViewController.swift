//
//  ConfigServerViewController.swift
//  mALS test
//
//  Created by Joshua Herrera on 7/16/15.
//  Copyright (c) 2015 Joshua Herrera. All rights reserved.
//

import UIKit

protocol SettingsServerViewControllerDataSource: class {
    var ssid: String? { get set }
    var securityType: String? { get set }
    var password: String? { get set }
    var deviceId: String? { get }
    var firstNameConfig: String? { get set }
    var lastNameConfig: String? { get set }
    var location: String? { get set }
    var host: String? { get set }
    var port: Int? { get set }
    var age: Int { get set }
    
    func isConnectedToDevice() -> Bool 
    func addProfile()
    func removeProfile()
    func resetVariables()
    func numberOfProfiles() -> Int?
}

class SettingsServerViewController: UIViewController, UITextFieldDelegate {
    // Labels that will only be updated
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var deviceIDLabel: UILabel!
    @IBOutlet weak var doNotChangeDeviceIdLabel: UILabel!
    @IBOutlet weak var ssidTextField: UITextField!
    @IBOutlet weak var secruityTypeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var roomNumTextField: UITextField!
    @IBOutlet weak var hostTextField: UITextField!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var portLabel: UILabel!
    @IBOutlet weak var securityTypeTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    @IBOutlet var wrapperView: UIView!
    var scrollView: AutoKeyboardScrollView!
    
    var views = [String: UIView]()
    
    var check: Int = 0
    
    // All text fields below are action based off of "Editing Did End"
    // Possibly will check out "Value Changed"
    @IBAction func ssidTextField(sender: UITextField) {
        self.dataSource?.ssid = sender.text
        self.updateAddButton()
    }
    
    @IBAction func passwordTextField(sender: UITextField) {
        self.dataSource?.password = sender.text
        self.updateAddButton()
    }
    
    @IBAction func firstNameTextField(sender: UITextField) {
        self.dataSource?.firstNameConfig = sender.text
        self.updateAddButton()
    }
    
    @IBAction func lastNameTextField(sender: UITextField) {
        self.dataSource?.lastNameConfig = sender.text
        self.updateAddButton()
    }
    
    @IBAction func roomNumberTextField(sender: UITextField) {
        self.dataSource?.location = sender.text
        self.updateAddButton()
    }
    
    @IBAction func securityTypeTextField(sender: UITextField) {
        self.dataSource?.securityType = sender.text
        self.updateAddButton()
    }
    
    @IBAction func addProfile(sender: UIButton) {
        if(self.dataSource?.numberOfProfiles() == 0) {
            self.addButton.enabled = true
            self.dataSource?.addProfile()
            self.addButton.enabled = false
            self.updateRemoveButton()
        }
    }
    
    @IBAction func removeProfile(sender: UIButton) {
        if(self.dataSource?.numberOfProfiles() == 1) {
            self.dataSource?.removeProfile()
            self.dataSource?.resetVariables()
            self.updateRemoveButton()
            self.updateTextFields()
            self.updateLabels()
        }
    }


//    @IBAction func hostTextField(sender: UITextField) {
//        self.dataSource?.host = sender.text
//    }
//    @IBAction func portTextField(sender: UITextField) {
//        self.dataSource?.port = sender.text.toInt()
//    }
    
    weak var dataSource: SettingsServerViewControllerDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var timer = NSTimer(fireDate: NSDate(timeIntervalSinceNow: 5.0), interval: 1.0, target: self, selector: Selector("updateLabels"), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
        // Do any additional setup after loading the view.
        
        self.setupAutoScroll()
        self.setupAutoScrollConstraints()
        self.addButton.enabled = false
    }
    
    override func viewDidAppear(animated: Bool) {
        self.updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Sets the size of the custom scrollView for the phone being used.
    override func viewDidLayoutSubviews() {
        self.scrollView.contentViewHasSameHeightWithScrollView = true
        self.scrollView.contentView.bounds.size.height = self.wrapperView.bounds.size.height + 100
        self.scrollView.contentViewHasSameWidthWithScrollView = true
        self.updateTextFields()
        self.updateAddButton()
        self.updateRemoveButton()
    }

    
    // Necessary for the autoscrolltextfield custom class that is used.
    // A custom autoscroll class object is made and is added as a subview of the main view on that controller. Then the wrapper view is removed from the super view and added as a subview to the contentView of the custom autoscroll view. (Normal scrollViews do not have a contentView.)
    func setupAutoScroll() {
        
        scrollView = AutoKeyboardScrollView()
        self.view.addSubview(scrollView)
        self.wrapperView.removeFromSuperview()
        self.scrollView.contentView.addSubview(wrapperView)
        self.wrapperView.setTranslatesAutoresizingMaskIntoConstraints(false)
    
        self.scrollView.userInteractionEnabled = true
        self.scrollView.bounces = true
        self.scrollView.scrollEnabled = true
        self.scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    }
    
    // Necessary for the autoscrolltextfield custom class that is used.
    func setupAutoScrollConstraints() {
        views["scrollView"] = scrollView
        views["wrapperView"] = wrapperView
        
        
    //  self.statusLabel.hidden = true
        self.doNotChangeDeviceIdLabel.hidden = true
        self.deviceIDLabel.hidden = true
        self.hostLabel.hidden = true
        self.portLabel.hidden = true
        self.hostTextField.hidden = true
        self.portTextField.hidden = true
        self.securityTypeTextField.enabled = false
        
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: NSLayoutFormatOptions(1), metrics: nil, views: views) as! [NSLayoutConstraint]
        constraints +=  NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: NSLayoutFormatOptions(1), metrics: nil, views: views) as! [NSLayoutConstraint]
        
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[wrapperView]|", options: NSLayoutFormatOptions(1), metrics: nil, views: views) as! [NSLayoutConstraint]
        constraints +=  NSLayoutConstraint.constraintsWithVisualFormat("V:|[wrapperView]|", options: NSLayoutFormatOptions(1), metrics: nil, views: views) as! [NSLayoutConstraint]

        NSLayoutConstraint.activateConstraints(constraints)
        
    }
    
    // Updates the textfields and fills them in with the current profile added. If no profile is there. Then the textfields will be empty.
    func updateTextFields() {
        self.ssidTextField.text = self.dataSource?.ssid
        self.passwordTextField.text = self.dataSource?.password
        self.firstNameTextField.text = self.dataSource?.firstNameConfig
        self.lastNameTextField.text = self.dataSource?.lastNameConfig
        self.roomNumTextField.text = self.dataSource?.location
    }
    
    // Updates the labels that affect the device status, and the device ID. Tells if the device status is connected/disconnected.
    func updateLabels() {
        if ((self.dataSource?.isConnectedToDevice())!) {
            self.statusLabel?.text = "Connected"
            self.statusLabel?.textColor = statusLabel.tintColor
        }
        else {
            self.statusLabel.text = "Disconneted"
            self.statusLabel?.textColor = UIColor(red: 255/255, green: 127/255, blue: 0/255, alpha: 255/255)
        }
        self.deviceIDLabel.text = dataSource?.deviceId
        self.deviceIDLabel.textColor = UIColor.blackColor()
    }
    
    // Temporarily disabled ssidTextField since it may not be necessary
    // Checks if all the textfields have something in them. If they do then the add button becomes enabled
    func updateAddButton() {
        var checkFlag: Bool = false
        if(!(self.firstNameTextField.text.isEmpty)){
            if(!(self.lastNameTextField.text.isEmpty)){
                if(!(self.ssidTextField.text.isEmpty)){
                    //if(!(self.secruityTypeTextField.text.isEmpty)){
                        if(!(self.passwordTextField.text.isEmpty)){
                            if(!(self.roomNumTextField.text.isEmpty)){
                                if(self.dataSource?.numberOfProfiles() == 0){
                                    self.addButton.enabled = true
                                    checkFlag = true
                                }
                            }
                        //}
                    }
                }
            }
        }
        if(checkFlag == false) {
            self.addButton.enabled = false
        }
    }
    
    func updateRemoveButton() {
        if(self.dataSource?.numberOfProfiles() == 1) {
            self.removeButton.enabled = true
        }
        else {
            self.removeButton.enabled = false
        }
    }
    
}
