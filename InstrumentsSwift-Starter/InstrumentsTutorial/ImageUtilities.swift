//
//  ImageUtilities.swift
//  InstrumentsTutorial
//
//  Created by James Frost on 11/03/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

private let _sharedCache = ImageCache()

class ImageCache {
    var images = [String:UIImage]()
    
    class var sharedCache: ImageCache {
        return _sharedCache
    }
    
    
    // When a memory warning is sent out, we must clear the cache or else a memory leak will occur
    init() {
        NSNotificationCenter.defaultCenter().addObserverForName(
            UIApplicationDidReceiveMemoryWarningNotification,
            object: nil,
            queue: NSOperationQueue.mainQueue()) { notification in
                self.images.removeAll(keepCapacity: false)
        }
    }
    
    // unsubscribe from notifications here
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIApplicationDidReceiveMemoryWarningNotification,
                                                            object: nil)
    }
    
    
    func setImage(image: UIImage, forKey key: String) {
        images[key] = image
    }
    
    func imageForKey(key: String) -> UIImage? {
        return images[key]
    }
}

extension UIImage {
    func applyTonalFilter() -> UIImage? {
        let context = CIContext(options:nil)
        let filter = CIFilter(name:"CIPhotoEffectTonal")
        let input = CoreImage.CIImage(image: self)
        filter!.setValue(input, forKey: kCIInputImageKey)
        let outputImage = filter!.outputImage
        
        let outImage = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let returnImage = UIImage(CGImage: outImage)
        return returnImage
    }
}