//
//  ConfigPageViewController.swift
//  mALS test
//
//  Created by Joshua Herrera on 7/14/15.
//  Copyright (c) 2015 Joshua Herrera. All rights reserved.
//

import UIKit

class MainCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var reuseIdentifier = [String]()
    var cellImages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
  
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reuseIdentifier.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> MyCollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("test",
        forIndexPath: indexPath) as! UICollectionViewCell
        
        // Configure the cell
        let image = UIImage(named: cellImages[o])
        cell.backgroundColor = cell.tintColor
        
        return cell
    }
}

class MyCollectionViewCell: MyCollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}
