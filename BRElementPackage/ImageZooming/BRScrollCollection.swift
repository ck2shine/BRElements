//
//  BRScrollCollection.swift
//  BRElementPackage
//
//  Created by Shine on 2020/1/5.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit



class BRScrollCollection: UICollectionViewController {

    private let reuseIdentifier = "BRZoomPhotoCell"
    
    private var photoAry : [String] = ["Snowboard.JPG" , "River.JPG" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
      
        // Do any additional setup after loading the view.
    }
   
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoAry.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BRZoomPhotoCell
    
        
        let photoName = photoAry[indexPath.row]
       
        cell.PhotoImageView.image = UIImage(named: photoName)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPageManager" , let toManager = segue.destination as? BRPageManagerViewController , let cell = sender as? BRZoomPhotoCell, let indexPath = collectionView?.indexPath(for: cell){
           
            toManager.photoAry = photoAry
            toManager.currentIdx = indexPath.row
        }
    }
}

extension BRScrollCollection : UICollectionViewDelegateFlowLayout{
    
}
