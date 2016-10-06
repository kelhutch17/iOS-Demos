//
//  UIImage+SwizzledImageName.m
//  MethodSwizzling
//
//  Created by Hutchison, Kelly on 10/5/16.
//  Copyright © 2016 Hutchison, Kelly. All rights reserved.
//

#import "UIImage+SwizzledImageName.h"
#import <objc/runtime.h> // Needed for method swizzling

// This category is to swizzle the imageNamed: function which is a function of the UIImage class
@implementation UIImage (SwizzledImageName)

// Note: load is executed automatically by the runtime
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // Get the names of the original and new selectors
        SEL originalSelector = @selector(imageNamed:);
        SEL swizzledSelector = @selector(swizzled_imageNamed:);
        
        // Obtain the actual method objects for each selector
        Method originalMethod = class_getClassMethod(class, originalSelector);
        Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
        
        // Make the exchange at runtime for the methods
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

// Now whenever imageNamed: is called in the app, this function will be called instead
// This is because we have swapped the methods and names
+ (UIImage *)swizzled_imageNamed:(NSString *)name {
    
    // Call the original imageNamed: function here
    // We call the swizzled_imageNamed: method because behind the scenes, the methods were switched.
    // This is not a recursive call, it will execute the actual imageNamed: function
    id result = [self swizzled_imageNamed:name];
    
    // If image does not exist then print the image name and crash the app
    if (result == nil) {
        NSLog(@"Image not found for name => %@", name);
        @throw NSInternalInconsistencyException;
    }
    
    return result;
}

@end
