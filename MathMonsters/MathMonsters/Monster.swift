/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

//an enum that defines a number of weapon options
enum Weapon {
  case Blowgun, NinjaStar, Fire, Sword, Smoke
}

class Monster {
  let name: String
  let description: String
  let iconName: String
  let weapon: Weapon

  // designated initializer for a Monster
  init(name: String, description: String, iconName: String, weapon: Weapon) {
    self.name = name
    self.description = description
    self.iconName = iconName
    self.weapon = weapon
  }

  // Convenience method for fetching a monster's weapon image
  func weaponImage() -> UIImage? {
    switch self.weapon {
    case .Blowgun:
      return UIImage(named: "blowgun.png")
    case .Fire:
      return UIImage(named: "fire.png")
    case .NinjaStar:
      return UIImage(named: "ninjastar.png")
    case .Smoke:
      return UIImage(named: "smoke.png")
    case .Sword:
      return UIImage(named: "sword.png")
    }
  }
}
