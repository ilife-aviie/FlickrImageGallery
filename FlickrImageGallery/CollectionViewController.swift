//
//  CollectionViewController.swift
//  FlickrImageGallery
//
//  Created by Avie on 02/10/17.
//  Copyright © 2017 xyz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    var feedsData: [FeedData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Flickr Image Gallery"
        
        Loader().loadFeeds { feedsData in
            self.feedsData = feedsData
            self.collectionView?.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.feedsData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Cell
        cell.imageView.af_setImage(withURL: URL(string: self.feedsData[indexPath.row].imageUrl)!, placeholderImage: #imageLiteral(resourceName: "placeholder"))
        return cell
    }
}
