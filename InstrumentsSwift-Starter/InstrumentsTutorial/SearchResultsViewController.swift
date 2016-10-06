//
//  SearchResultsViewController.swift
//  InstrumentsTutorial
//
//  Created by James Frost on 28/02/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class SearchResultsCollectionViewCell : UICollectionViewCell {
  
  @IBOutlet weak var heartButton: UIButton!
  @IBOutlet weak var imageView: UIImageView!
  
  var flickrPhoto: FlickrPhoto! {
    didSet {
      if flickrPhoto.isFavourite {
        heartButton.tintColor = UIColor(red:1, green:0, blue:0.517, alpha:1)
      } else {
        heartButton.tintColor = UIColor.whiteColor()
      }
    }
  }
  
  var heartToggleHandler: ((isFavourite: Bool) -> Void)?

  override func prepareForReuse() {
    imageView.image = nil
  }
  
  @IBAction func heartTapped(sender: AnyObject) {
    flickrPhoto.isFavourite = !flickrPhoto.isFavourite
    
    heartToggleHandler?(isFavourite: flickrPhoto.isFavourite)
  }
}

class SearchResultsViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var searchResults: FlickrSearchResults?
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    let resultsCount = searchResults!.searchResults.count
    
    title = "\(searchResults!.searchTerm) (\(resultsCount))"
  }
}

extension SearchResultsViewController : UICollectionViewDataSource {
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return searchResults!.searchResults.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! SearchResultsCollectionViewCell
    
    if let flickrPhoto = searchResults?.searchResults[indexPath.item] {
      cell.flickrPhoto = flickrPhoto
      
        // memory leak was occurring here before weak self was captured
      cell.heartToggleHandler = { [weak self] isStarred in
        if let strongSelf = self {
            strongSelf.collectionView.reloadItemsAtIndexPaths([ indexPath ])
        }
      }

        // This was causing a timing performance issue before we applied the tonal filter not on the main thread
        // and caching the images
        flickrPhoto.loadThumbnail { image, error in
            if cell.flickrPhoto == flickrPhoto {
                if flickrPhoto.isFavourite {
                    cell.imageView.image = image
                } else {
                    // Check if the image is cached before downloading it again
                    if let cachedImage = ImageCache.sharedCache.imageForKey("\(flickrPhoto.photoID)-filtered") {
                        cell.imageView.image = cachedImage
                    } else {
                        // Filter the image on not the main queue. This will prevent the app from being 
                        // unusable and frozen while the applyTonalFilter executes
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                            if let filteredImage = image?.applyTonalFilter() {
                                ImageCache.sharedCache.setImage(filteredImage, forKey: "\(flickrPhoto.photoID)-filtered")
                                // When the filtering is finished, apply the changes on the main queue
                                // All UI work must be completed on the main thread
                                dispatch_async(dispatch_get_main_queue(), {
                                    cell.imageView.image = filteredImage
                                })
                            }
                        })
                    }
                }
            }
        }
    }
    
    return cell
  }
  
}

extension SearchResultsViewController : UICollectionViewDelegateFlowLayout
{
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    // 3 images across
    let width = view.bounds.width / 3
    
    // each image has a ratio of 4:3
    let height = (width / 4) * 3
    return CGSize(width: width, height: height)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 0
  }
}


