//
//  Letters.swift
//  Bridging
//
//  Created by Hutchison, Kelly on 10/5/16.
//  Copyright © 2016 Hutchison, Kelly. All rights reserved.
//

import Foundation

class Letters: NSObject {
    func favoriteLetters() -> [String] {
        return ["W", "E", "A", "R", "E", "P", "S", "U"]
    }
    
    // Uses functions from this class and another Swift class
    func favoriteNumbersAndLetters() -> [String] {
        // Numbers is another Swift class. We are able to call it from this Swift class "for free" without any import statments.
        let numbers = Numbers()
        return favoriteLetters() + numbers.favoriteNumbers()
    }
    
    // Uses functions from this class and from an objc class
    func allTheThings() -> [String] {
        
        // Words is an obj c class. We are able to use it because it is imported in our app's bridging header.
        let words = Words()
        return favoriteNumbersAndLetters() + words.favoriteWords()
    }
}